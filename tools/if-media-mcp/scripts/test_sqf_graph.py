"""
Tests del tokenizador y extractor de llamadas de sqf_graph.py.

Cada caso aquí viene de un problema real encontrado probando el script contra
código real (Islas Fracturadas y AI_REFERENCES/A3-Antistasi), no de casos
inventados en el vacío — ver el historial de la sesión que escribió este archivo.
"""
import unittest
from pathlib import Path
import sys

sys.path.insert(0, str(Path(__file__).parent))
from sqf_graph import tokenize_sqf, extract_edges, build_function_registry, extract_mission_inits, IF_FNC_PATTERN


class TokenizerTests(unittest.TestCase):
    def test_ignores_call_inside_line_comment(self):
        edges = self._edges('// call IF_fnc_shouldNotAppear\n[] call IF_fnc_real;')
        self.assertEqual([e.target for e in edges], ['IF_fnc_real'])

    def test_ignores_call_inside_block_comment(self):
        edges = self._edges('/* Example: [] call IF_fnc_shouldNotAppear; */\n[] call IF_fnc_real;')
        self.assertEqual([e.target for e in edges], ['IF_fnc_real'])

    def test_ignores_call_inside_string_literal(self):
        edges = self._edges('private _x = "this text says call IF_fnc_fake but is a string";\n[] call IF_fnc_real;')
        self.assertEqual([e.target for e in edges], ['IF_fnc_real'])

    def test_handles_doubled_quote_escaping(self):
        # SQF escapa comillas duplicándolas: "it""s a test" es una sola string.
        tokens = tokenize_sqf('private _x = "it""s call IF_fnc_fake a test"; [] call IF_fnc_real;')
        strings = [t.value for t in tokens if t.kind == 'string']
        self.assertEqual(strings, ['it"s call IF_fnc_fake a test'])

    def test_flags_call_to_variable_as_dynamic_not_silently_dropped(self):
        edges = self._edges('[] call _handler;')
        self.assertEqual(len(edges), 1)
        self.assertEqual(edges[0].kind, 'dynamic')
        self.assertIn('_handler', edges[0].target)

    def test_flags_call_to_macro_as_dynamic(self):
        edges = self._edges('call FUNC(something);')
        self.assertEqual(len(edges), 1)
        self.assertEqual(edges[0].kind, 'dynamic')
        self.assertIn('FUNC', edges[0].target)

    def test_flags_call_compile_as_dynamic(self):
        edges = self._edges('[] call compile _someCode;')
        self.assertEqual(len(edges), 1)
        self.assertEqual(edges[0].kind, 'dynamic')

    def test_resolves_spawn_same_as_call(self):
        edges = self._edges('[] spawn IF_fnc_real;')
        self.assertEqual([e.target for e in edges], ['IF_fnc_real'])

    def test_unresolved_name_when_not_in_registry_but_matches_pattern(self):
        edges = self._edges('[] call IF_fnc_notRegistered;', registry={})
        self.assertEqual(edges[0].kind, 'unresolved_name')

    def test_static_when_present_in_registry(self):
        edges = self._edges('[] call IF_fnc_real;', registry={'IF_fnc_real': 'core/fn_real.sqf'})
        self.assertEqual(edges[0].kind, 'static')

    def test_remote_exec_string_target_detected(self):
        edges = self._edges('[[], "IF_fnc_real", 0] remoteExec ["IF_fnc_real", 0];')
        self.assertIn('IF_fnc_real', [e.target for e in edges])

    def test_ignores_native_command_after_call_that_is_not_if_fnc(self):
        # `call` seguido de un comando/macro que no es ni IF_fnc_* ni variable ni macro-con-parentesis
        # inmediatamente después no debe generar ruido si no matchea ningún patrón conocido.
        edges = self._edges('[] call compile preprocessFileLineNumbers "x.sqf";')
        # 'compile' ya se captura como dynamic explícito; no debe haber una segunda arista falsa.
        self.assertEqual(len(edges), 1)

    def _edges(self, code, registry=None):
        tokens = tokenize_sqf(code)
        return extract_edges(tokens, 'TEST_SOURCE', registry or {})


class MissionInitTests(unittest.TestCase):
    def test_finds_real_init_field(self):
        mission = {
            "Mission": {
                "Entities": {
                    "Item0": {
                        "dataType": "Object",
                        "Attributes": {"init": '[] call IF_fnc_real;'}
                    }
                }
            }
        }
        results = extract_mission_inits(mission)
        self.assertEqual(len(results), 1)
        self.assertIn("call IF_fnc_real", results[0][1])

    def test_ignores_custom_attributes_expression_boilerplate(self):
        # CustomAttributes/*/expression es boilerplate del editor 3DEN (setVariable de
        # atributos de UI), nunca lógica de misión escrita por una persona.
        mission = {
            "Mission": {
                "Entities": {
                    "Item0": {
                        "CustomAttributes": {
                            "Attribute0": {"expression": "_this setVariable ['Owner', _value, true];"}
                        }
                    }
                }
            }
        }
        results = extract_mission_inits(mission)
        self.assertEqual(results, [])

    def test_ignores_init_nested_inside_custom_attributes(self):
        # Si alguna vez "init" apareciera dentro de CustomAttributes, sigue sin ser un
        # init real de entidad — se ignora igual que expression.
        mission = {
            "Mission": {
                "Entities": {
                    "Item0": {
                        "CustomAttributes": {
                            "Attribute0": {"init": "not a real entity init"}
                        }
                    }
                }
            }
        }
        results = extract_mission_inits(mission)
        self.assertEqual(results, [])

    def test_mission_edges_get_synthetic_source_prefix(self):
        mission = {"Mission": {"Entities": {"Item0": {"Attributes": {"init": "[] call IF_fnc_real;"}}}}}
        inits = extract_mission_inits(mission)
        tokens = tokenize_sqf(inits[0][1])
        edges = extract_edges(tokens, f"mission.sqm:{inits[0][0]}", {})
        self.assertTrue(edges[0].source.startswith("mission.sqm:"))


class RegistryTests(unittest.TestCase):
    def test_builds_registry_from_cfgfunctions_shape(self):
        cfg = {
            'CfgFunctions': {
                'IF': {
                    'tag': 'IF',
                    'Bootstrap': {
                        'file': 'core\\bootstrap',
                        'bootstrapPreInit': {'preInit': 1},
                        'bootstrapPostInit': {'postInit': 1},
                    }
                }
            }
        }
        registry = build_function_registry(cfg, Path('.'))
        self.assertEqual(registry['IF_fnc_bootstrapPreInit'], 'core/bootstrap/fn_bootstrapPreInit.sqf')
        self.assertEqual(registry['IF_fnc_bootstrapPostInit'], 'core/bootstrap/fn_bootstrapPostInit.sqf')

    def test_if_fnc_pattern_matches_any_tag(self):
        self.assertTrue(IF_FNC_PATTERN.match('A3A_Events_fnc_triggerEvent'))
        self.assertTrue(IF_FNC_PATTERN.match('IF_fnc_log'))
        self.assertFalse(IF_FNC_PATTERN.match('_privateVar'))
        self.assertFalse(IF_FNC_PATTERN.match('FUNC'))


if __name__ == '__main__':
    unittest.main()
