import unittest
from pathlib import Path
from tempfile import TemporaryDirectory
import sys

sys.path.insert(0, str(Path(__file__).parent))
from sqm_patch import find_entity_block_span, patch_array_field, apply_patch, PatchError

SAMPLE = (
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


if __name__ == "__main__":
    unittest.main()
