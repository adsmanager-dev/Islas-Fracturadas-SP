import unittest
from pathlib import Path
from tempfile import TemporaryDirectory
import sys

sys.path.insert(0, str(Path(__file__).parent))
import armaclass
from sqm_patch import (
    find_entity_block_span,
    patch_array_field,
    patch_scalar_field,
    read_field_value,
    apply_patch,
    add_object_entity,
    apply_add_object_entity,
    delete_entity,
    apply_delete_entity,
    _index_raw_entities_by_id,
    _find_root_entities_span,
    PatchError,
)

SAMPLE = (
    "version=54;\r\n"
    "class Mission\r\n"
    "{\r\n"
    "\tclass Entities\r\n"
    "\t{\r\n"
    "\t\titems=2;\r\n"
    "\t\tclass Item0\r\n"
    "\t\t{\r\n"
    "\t\t\tdataType=\"Object\";\r\n"
    "\t\t\tclass PositionInfo\r\n"
    "\t\t\t{\r\n"
    "\t\t\t\tposition[]={100,5,200};\r\n"
    "\t\t\t};\r\n"
    "\t\t\tid=42;\r\n"
    "\t\t\ttype=\"B_Soldier_F\";\r\n"
    "\t\t};\r\n"
    "\t\tclass Item1\r\n"
    "\t\t{\r\n"
    "\t\t\tdataType=\"Object\";\r\n"
    "\t\t\tclass PositionInfo\r\n"
    "\t\t\t{\r\n"
    "\t\t\t\tposition[]={300,5,400};\r\n"
    "\t\t\t};\r\n"
    "\t\t\tid=43;\r\n"
    "\t\t\ttype=\"B_Soldier_F\";\r\n"
    "\t\t};\r\n"
    "\t};\r\n"
    "};\r\n"
)


class FindEntityBlockSpanTests(unittest.TestCase):
    def test_finds_correct_block_for_id(self):
        start, end = find_entity_block_span(SAMPLE, 42)
        block = SAMPLE[start:end]
        self.assertIn("id=42;", block)
        self.assertNotIn("id=43;", block)

    def test_raises_when_id_missing(self):
        with self.assertRaises(PatchError):
            find_entity_block_span(SAMPLE, 999)

    def test_raises_when_id_duplicated(self):
        duplicated = SAMPLE.replace("id=43;", "id=42;")
        with self.assertRaises(PatchError):
            find_entity_block_span(duplicated, 42)


class PatchArrayFieldTests(unittest.TestCase):
    def test_patches_only_target_entity_position(self):
        result = patch_array_field(SAMPLE, 42, "position", [111.0, 6.0, 222.0])
        self.assertIn("position[]={111,6,222};", result)
        self.assertIn("position[]={300,5,400};", result)  # Item1 intacto

    def test_preserves_everything_outside_the_one_line(self):
        result = patch_array_field(SAMPLE, 43, "position", [999.0, 1.0, 2.0])
        original_lines = SAMPLE.splitlines()
        patched_lines = result.splitlines()
        self.assertEqual(len(original_lines), len(patched_lines))
        diffs = [i for i in range(len(original_lines)) if original_lines[i] != patched_lines[i]]
        self.assertEqual(len(diffs), 1)

    def test_raises_for_unsupported_field(self):
        with self.assertRaises(PatchError):
            patch_array_field(SAMPLE, 42, "type", [1])

    def test_raises_when_field_does_not_exist_on_entity(self):
        no_angles = SAMPLE  # ninguna entidad de muestra tiene angles[]
        with self.assertRaises(PatchError):
            patch_array_field(no_angles, 42, "angles", [0, 0, 0])


class AddObjectEntityTests(unittest.TestCase):
    def test_appends_new_item_and_bumps_items_counter(self):
        data = armaclass.parse(SAMPLE)
        patched, new_id = add_object_entity(SAMPLE, data, "B_Soldier_F", [500.0, 6.0, 600.0])
        self.assertEqual(new_id, 44)  # max existente era 43
        self.assertIn("items=3;", patched)
        self.assertIn("class Item2", patched)
        self.assertIn("id=44;", patched)
        self.assertIn('type="B_Soldier_F";', patched)
        # las dos entidades originales siguen intactas
        self.assertIn("id=42;", patched)
        self.assertIn("id=43;", patched)

    def test_new_block_is_parseable_and_has_expected_shape(self):
        data = armaclass.parse(SAMPLE)
        patched, new_id = add_object_entity(
            SAMPLE, data, "Land_PaperBox_closed_F", [1.0, 2.0, 3.0],
            side="West", angles=[0.0, 1.5, 0.0], name="IF_test_box", init='hint "hi"', skill=0.7,
        )
        reparsed = armaclass.parse(patched)
        entities = reparsed["Mission"]["Entities"]
        new_entity = entities["Item2"]
        self.assertEqual(new_entity["id"], new_id)
        self.assertEqual(new_entity["type"], "Land_PaperBox_closed_F")
        self.assertEqual(new_entity["PositionInfo"]["position"], [1.0, 2.0, 3.0])
        self.assertEqual(new_entity["PositionInfo"]["angles"], [0.0, 1.5, 0.0])
        self.assertEqual(new_entity["side"], "West")
        self.assertEqual(new_entity["Attributes"]["name"], "IF_test_box")
        self.assertEqual(new_entity["Attributes"]["init"], 'hint "hi"')
        self.assertEqual(new_entity["Attributes"]["skill"], 0.7)

    def test_bumps_next_id_when_present(self):
        with_provider = SAMPLE.replace(
            "class Mission\r\n",
            "class EditorData\r\n{\r\n\tclass ItemIDProvider\r\n\t{\r\n\t\tnextID=44;\r\n\t};\r\n};\r\nclass Mission\r\n",
        )
        data = armaclass.parse(with_provider)
        patched, new_id = add_object_entity(with_provider, data, "B_Soldier_F", [0.0, 0.0, 0.0])
        self.assertIn(f"nextID={new_id + 1};", patched)

    def test_does_not_lower_next_id_if_already_higher(self):
        with_provider = SAMPLE.replace(
            "class Mission\r\n",
            "class EditorData\r\n{\r\n\tclass ItemIDProvider\r\n\t{\r\n\t\tnextID=9999;\r\n\t};\r\n};\r\nclass Mission\r\n",
        )
        data = armaclass.parse(with_provider)
        patched, _ = add_object_entity(with_provider, data, "B_Soldier_F", [0.0, 0.0, 0.0])
        self.assertIn("nextID=9999;", patched)

    def test_raises_when_computed_id_already_exists(self):
        # Fuerza una colisión: hay un id=44 suelto en el archivo aunque no sea
        # una entidad "real" para armaclass — la defensa debe abortar igual.
        colliding = SAMPLE.replace("id=43;", "id=43;\r\n\t\t\t/* nota: id=44; ya usado en otro lado */")
        data = armaclass.parse(SAMPLE)
        with self.assertRaises(PatchError):
            add_object_entity(colliding, data, "B_Soldier_F", [0.0, 0.0, 0.0])

    def test_raises_when_root_entities_empty(self):
        empty = (
            "version=54;\r\n"
            "class Mission\r\n{\r\n\tclass Entities\r\n\t{\r\n\t\titems=0;\r\n\t};\r\n};\r\n"
        )
        data = armaclass.parse(empty)
        with self.assertRaises(PatchError):
            add_object_entity(empty, data, "B_Soldier_F", [0.0, 0.0, 0.0])


class FindRootEntitiesSpanTests(unittest.TestCase):
    def test_finds_root_not_nested_entities(self):
        nested_sample = SAMPLE.replace(
            'type="B_Soldier_F";\r\n\t\t};',
            'type="B_Soldier_F";\r\n\t\t\tclass Entities\r\n\t\t\t{\r\n\t\t\t\titems=0;\r\n\t\t\t};\r\n\t\t};',
            1,
        )
        start, end = _find_root_entities_span(nested_sample)
        span = nested_sample[start:end]
        # El bloque raíz debe contener AMBAS entidades de nivel superior, y su
        # `items=` debe ser el 2 original (raíz), no el 0 del anidado.
        self.assertIn("id=42;", span)
        self.assertIn("id=43;", span)
        self.assertRegex(span, r"items\s*=\s*2\s*;")


class ApplyAddObjectEntityIntegrationTests(unittest.TestCase):
    def test_full_apply_add_creates_backup_and_new_entity(self):
        with TemporaryDirectory() as tmp:
            tmp_path = Path(tmp)
            mission = tmp_path / "mission.sqm"
            mission.write_bytes(SAMPLE.encode("utf-8"))
            draft = tmp_path / "patched.sqm"
            backups = tmp_path / "backups"

            result = apply_add_object_entity(
                mission, None, "B_Soldier_F", [500.0, 6.0, 600.0],
                None, None, None, None, None,
                draft, backups,
            )

            self.assertTrue(result.ok)
            self.assertEqual(result.entities_after, result.entities_before + 1)
            self.assertEqual(result.unrelated_entities_changed, [])
            self.assertTrue(Path(result.backup_path).is_file())
            self.assertEqual(Path(result.backup_path).read_bytes(), SAMPLE.encode("utf-8"))
            draft_text = draft.read_text(encoding="utf-8")
            self.assertIn(f"id={result.new_entity_id};", draft_text)
            # El archivo original en su ruta real nunca se toca:
            self.assertEqual(mission.read_bytes(), SAMPLE.encode("utf-8"))


class DeleteEntityTests(unittest.TestCase):
    def test_deletes_last_entity_and_decrements_items(self):
        data = armaclass.parse(SAMPLE)
        patched = delete_entity(SAMPLE, data, 43)  # Item1, la última
        self.assertIn("items=1;", patched)
        self.assertNotIn("id=43;", patched)
        self.assertIn("id=42;", patched)  # Item0 intacta

    def test_result_is_parseable_and_only_first_entity_remains(self):
        data = armaclass.parse(SAMPLE)
        patched = delete_entity(SAMPLE, data, 43)
        reparsed = armaclass.parse(patched)
        entities = reparsed["Mission"]["Entities"]
        self.assertNotIn("Item1", entities)
        self.assertEqual(entities["Item0"]["id"], 42)

    def test_raises_when_not_the_last_entity(self):
        data = armaclass.parse(SAMPLE)
        with self.assertRaises(PatchError):
            delete_entity(SAMPLE, data, 42)  # Item0, no es la última

    def test_raises_when_root_entities_empty(self):
        empty = (
            "version=54;\r\n"
            "class Mission\r\n{\r\n\tclass Entities\r\n\t{\r\n\t\titems=0;\r\n\t};\r\n};\r\n"
        )
        data = armaclass.parse(empty)
        with self.assertRaises(PatchError):
            delete_entity(empty, data, 1)

    def test_add_then_delete_is_symmetric(self):
        # Comparación BYTE A BYTE, no solo estructural: armaclass.parse() ignora
        # diferencias de espacios en blanco fuera de strings, así que una
        # comparación solo estructural no habría detectado el bug real encontrado
        # en la prueba de estrés contra Antistasi (una línea en blanco sobrante
        # porque el borrado anclaba en el inicio de la propia línea borrada en vez
        # de en el final de la entidad anterior).
        data = armaclass.parse(SAMPLE)
        added_text, new_id = add_object_entity(SAMPLE, data, "B_Soldier_F", [1.0, 2.0, 3.0])
        added_data = armaclass.parse(added_text)
        restored = delete_entity(added_text, added_data, new_id)
        self.assertEqual(restored, SAMPLE)

    def test_raises_when_only_one_entity_remains(self):
        one_entity = SAMPLE.replace(
            "items=2;\r\n", "items=1;\r\n"
        ).replace(
            '\t\tclass Item1\r\n\t\t{\r\n\t\t\tdataType="Object";\r\n\t\t\tclass PositionInfo\r\n'
            "\t\t\t{\r\n\t\t\t\tposition[]={300,5,400};\r\n\t\t\t};\r\n\t\t\tid=43;\r\n"
            '\t\t\ttype="B_Soldier_F";\r\n\t\t};\r\n',
            "",
        )
        data = armaclass.parse(one_entity)
        item_keys = [k for k in data["Mission"]["Entities"] if k.startswith("Item")]
        self.assertEqual(item_keys, ["Item0"])  # sanity: solo Item0 quedó
        with self.assertRaises(PatchError):
            delete_entity(one_entity, data, 42)


class ApplyDeleteEntityIntegrationTests(unittest.TestCase):
    def test_full_apply_delete_removes_last_entity(self):
        with TemporaryDirectory() as tmp:
            tmp_path = Path(tmp)
            mission = tmp_path / "mission.sqm"
            mission.write_bytes(SAMPLE.encode("utf-8"))
            draft = tmp_path / "patched.sqm"
            backups = tmp_path / "backups"

            result = apply_delete_entity(mission, None, 43, draft, backups)

            self.assertTrue(result.ok)
            self.assertEqual(result.entities_after, result.entities_before - 1)
            self.assertEqual(result.unrelated_entities_changed, [])
            self.assertTrue(Path(result.backup_path).is_file())
            self.assertEqual(Path(result.backup_path).read_bytes(), SAMPLE.encode("utf-8"))
            draft_text = draft.read_text(encoding="utf-8")
            self.assertNotIn("id=43;", draft_text)
            self.assertIn("id=42;", draft_text)
            self.assertEqual(mission.read_bytes(), SAMPLE.encode("utf-8"))

    def test_raises_for_nonexistent_id(self):
        with TemporaryDirectory() as tmp:
            tmp_path = Path(tmp)
            mission = tmp_path / "mission.sqm"
            mission.write_bytes(SAMPLE.encode("utf-8"))
            draft = tmp_path / "patched.sqm"
            backups = tmp_path / "backups"

            with self.assertRaises(PatchError):
                apply_delete_entity(mission, None, 9999, draft, backups)


# Item0: unidad con name/skill anidados en class Attributes (patrón real verificado
# en AI_REFERENCES/A3-Antistasi: skill=0.2; dentro de class Attributes { ... };).
# Item1: marcador con name/text a nivel directo del bloque (patrón real: name=
# "airp_mortar_1";, text="Your Headquarters"; sin nesting).
SAMPLE_ATTRS = (
    "version=54;\r\n"
    "class Mission\r\n"
    "{\r\n"
    "\tclass Entities\r\n"
    "\t{\r\n"
    "\t\tclass Item0\r\n"
    "\t\t{\r\n"
    "\t\t\tdataType=\"Object\";\r\n"
    "\t\t\tclass PositionInfo\r\n"
    "\t\t\t{\r\n"
    "\t\t\t\tposition[]={100,5,200};\r\n"
    "\t\t\t};\r\n"
    "\t\t\tside=\"West\";\r\n"
    "\t\t\tclass Attributes\r\n"
    "\t\t\t{\r\n"
    "\t\t\t\tname=\"IF_soldier1\";\r\n"
    "\t\t\t\tskill=0.5;\r\n"
    "\t\t\t};\r\n"
    "\t\t\tid=42;\r\n"
    "\t\t\ttype=\"B_Soldier_F\";\r\n"
    "\t\t};\r\n"
    "\t\tclass Item1\r\n"
    "\t\t{\r\n"
    "\t\t\tdataType=\"Marker\";\r\n"
    "\t\t\tposition[]={300,5,400};\r\n"
    "\t\t\tname=\"hq_marker\";\r\n"
    "\t\t\ttext=\"Your Headquarters\";\r\n"
    "\t\t\tid=43;\r\n"
    "\t\t\ttype=\"hd_start\";\r\n"
    "\t\t};\r\n"
    "\t};\r\n"
    "};\r\n"
)


class PatchScalarFieldTests(unittest.TestCase):
    def test_patches_string_field_without_touching_other_entity(self):
        result = patch_scalar_field(SAMPLE_ATTRS, 42, "name", "IF_soldier1_renamed")
        self.assertIn('name="IF_soldier1_renamed";', result)
        self.assertIn('name="hq_marker";', result)  # Item1 intacto

    def test_patches_numeric_field_nested_in_attributes(self):
        result = patch_scalar_field(SAMPLE_ATTRS, 42, "skill", 0.9)
        self.assertIn("skill=0.9;", result)
        self.assertNotIn("skill=0.5;", result)

    def test_escapes_embedded_quotes_in_string_value(self):
        result = patch_scalar_field(SAMPLE_ATTRS, 43, "text", 'Say "hi"')
        self.assertIn('text="Say ""hi""";', result)

    def test_raises_for_unsupported_field(self):
        with self.assertRaises(PatchError):
            patch_scalar_field(SAMPLE_ATTRS, 42, "id", 1)

    def test_raises_when_field_does_not_exist_on_entity(self):
        with self.assertRaises(PatchError):
            patch_scalar_field(SAMPLE_ATTRS, 43, "skill", 0.5)  # el marcador no tiene skill


class ReadFieldValueTests(unittest.TestCase):
    def test_reads_numeric_scalar(self):
        self.assertEqual(read_field_value(SAMPLE_ATTRS, 42, "skill"), 0.5)

    def test_reads_string_scalar(self):
        self.assertEqual(read_field_value(SAMPLE_ATTRS, 43, "text"), "Your Headquarters")

    def test_reads_array_field(self):
        self.assertEqual(read_field_value(SAMPLE_ATTRS, 42, "position"), [100.0, 5.0, 200.0])

    def test_returns_none_when_field_absent(self):
        self.assertIsNone(read_field_value(SAMPLE_ATTRS, 43, "skill"))


class CrlfPreservationTests(unittest.TestCase):
    def test_output_keeps_original_crlf_without_doubling(self):
        # Regresión del bug real encontrado: write_text() sin newline="" duplicaba
        # el \r de cada línea (\r\n -> \r\r\n) porque el texto ya traía \r\n literal
        # desde una lectura en bytes, y el modo texto de Python los retraducía.
        result = patch_array_field(SAMPLE, 42, "position", [1.0, 2.0, 3.0])
        self.assertNotIn("\r\r\n", result)
        self.assertIn("\r\n", result)


class ApplyPatchIntegrationTests(unittest.TestCase):
    def test_full_apply_patch_creates_backup_and_surgical_draft(self):
        with TemporaryDirectory() as tmp:
            tmp_path = Path(tmp)
            mission = tmp_path / "mission.sqm"
            mission.write_bytes(SAMPLE.encode("utf-8"))
            draft = tmp_path / "patched.sqm"
            backups = tmp_path / "backups"

            result = apply_patch(mission, None, 42, "position", [111.0, 6.0, 222.0], draft, backups)

            self.assertTrue(result.ok)
            self.assertEqual(result.entities_before, result.entities_after)
            self.assertEqual(result.unrelated_entities_changed, [])
            self.assertTrue(Path(result.backup_path).is_file())
            self.assertEqual(Path(result.backup_path).read_bytes(), SAMPLE.encode("utf-8"))
            self.assertIn("position[]={111,6,222};", draft.read_text(encoding="utf-8"))
            # El archivo original en su ruta real nunca se toca:
            self.assertEqual(mission.read_bytes(), SAMPLE.encode("utf-8"))

    def test_ancestor_layer_not_flagged_when_nested_child_is_patched(self):
        # Regresión: AI_REFERENCES/A3-Antistasi organiza objetos en Layers anidados
        # (class Item{N} { dataType="Layer"; class Entities { ... hijos ... } };).
        # Como el subárbol de un Layer contiene a todos sus descendientes, comparar
        # el nodo crudo COMPLETO de cada Layer haría que cambiar un hijo profundo
        # marcara a cada Layer ancestro como "cambiado" — falso positivo real,
        # encontrado al probar contra Antistasi_Enoch (ids 3184 y 3332 aparecían
        # como afectados al tocar solo skill= de un objeto anidado dos Layers abajo).
        nested = (
            "version=54;\r\n"
            "class Mission\r\n"
            "{\r\n"
            "\tclass Entities\r\n"
            "\t{\r\n"
            "\t\tclass Item0\r\n"
            "\t\t{\r\n"
            "\t\t\tdataType=\"Layer\";\r\n"
            "\t\t\tname=\"Airfields\";\r\n"
            "\t\t\tclass Entities\r\n"
            "\t\t\t{\r\n"
            "\t\t\t\titems=1;\r\n"
            "\t\t\t\tclass Item0\r\n"
            "\t\t\t\t{\r\n"
            "\t\t\t\t\tdataType=\"Object\";\r\n"
            "\t\t\t\t\tclass PositionInfo\r\n"
            "\t\t\t\t\t{\r\n"
            "\t\t\t\t\t\tposition[]={100,5,200};\r\n"
            "\t\t\t\t\t};\r\n"
            "\t\t\t\t\tclass Attributes\r\n"
            "\t\t\t\t\t{\r\n"
            "\t\t\t\t\t\tskill=0.2;\r\n"
            "\t\t\t\t\t};\r\n"
            "\t\t\t\t\tid=2926;\r\n"
            "\t\t\t\t\ttype=\"Land_PaperBox_closed_F\";\r\n"
            "\t\t\t\t};\r\n"
            "\t\t\t};\r\n"
            "\t\t\tid=3184;\r\n"
            "\t\t};\r\n"
            "\t};\r\n"
            "};\r\n"
        )
        with TemporaryDirectory() as tmp:
            tmp_path = Path(tmp)
            mission = tmp_path / "mission.sqm"
            mission.write_bytes(nested.encode("utf-8"))
            draft = tmp_path / "patched.sqm"
            backups = tmp_path / "backups"

            result = apply_patch(mission, None, 2926, "skill", 0.9, draft, backups)

            self.assertTrue(result.ok)
            self.assertEqual(result.unrelated_entities_changed, [])

    def test_index_raw_entities_excludes_nested_entities_key(self):
        indexed = _index_raw_entities_by_id({
            "Item0": {
                "dataType": "Layer", "id": 1, "name": "L",
                "Entities": {"items": 1, "Item0": {"dataType": "Object", "id": 2}},
            }
        })
        self.assertNotIn("Entities", indexed[1])
        self.assertEqual(indexed[2], {"dataType": "Object", "id": 2})

    def test_full_apply_patch_scalar_field_reports_old_and_new_value(self):
        with TemporaryDirectory() as tmp:
            tmp_path = Path(tmp)
            mission = tmp_path / "mission.sqm"
            mission.write_bytes(SAMPLE_ATTRS.encode("utf-8"))
            draft = tmp_path / "patched.sqm"
            backups = tmp_path / "backups"

            result = apply_patch(mission, None, 42, "skill", 0.9, draft, backups)

            self.assertTrue(result.ok)
            self.assertEqual(result.old_value, 0.5)
            self.assertEqual(result.new_value, 0.9)
            self.assertEqual(result.entities_before, result.entities_after)
            self.assertEqual(result.unrelated_entities_changed, [])
            self.assertIn("skill=0.9;", draft.read_text(encoding="utf-8"))
            self.assertIn('name="hq_marker";', draft.read_text(encoding="utf-8"))  # Item1 intacto


if __name__ == "__main__":
    unittest.main()
