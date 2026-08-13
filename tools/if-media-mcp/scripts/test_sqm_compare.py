import sys
import unittest
from pathlib import Path

sys.path.insert(0, str(Path(__file__).parent))
from sqm_compare import classify, walk


class ClassificationTests(unittest.TestCase):
    def test_classifies_camera_and_editor_metadata(self):
        self.assertEqual(classify("root.EditorData.Camera.pos[0]"), "CAMERA_METADATA")
        self.assertEqual(classify("root.EditorData.LayerIndexProvider.nextID"), "EDITOR_METADATA")

    def test_classifies_root_and_nested_entities_as_functional(self):
        self.assertEqual(classify("root.Mission.Entities.Item0.id"), "ENTITY_FUNCTIONAL")
        self.assertEqual(
            classify("root.Mission.Entities.Item0.Entities.Item1.position[2]"),
            "ENTITY_FUNCTIONAL",
        )
        self.assertEqual(classify("root.Mission.intel.year"), "MISSION_FUNCTIONAL")


class WalkTests(unittest.TestCase):
    def test_metadata_only_difference_remains_functionally_equal(self):
        repo = {
            "EditorData": {"Camera": {"pos": [1, 2, 3]}},
            "Mission": {"Entities": {"Item0": {"id": 7}}},
        }
        workspace = {
            "EditorData": {"Camera": {"pos": [4, 5, 6]}},
            "Mission": {"Entities": {"Item0": {"id": 7}}},
        }
        differences = walk(repo, workspace)
        self.assertEqual(len(differences), 3)
        self.assertEqual({item["classification"] for item in differences}, {"CAMERA_METADATA"})

    def test_entity_change_is_functional(self):
        repo = {"Mission": {"Entities": {"Item0": {"id": 7, "position": [1, 2, 3]}}}}
        workspace = {"Mission": {"Entities": {"Item0": {"id": 7, "position": [1, 2, 4]}}}}
        differences = walk(repo, workspace)
        self.assertEqual(differences, [{
            "path": "root.Mission.Entities.Item0.position[2]",
            "repo": 3,
            "workspace": 4,
            "classification": "ENTITY_FUNCTIONAL",
        }])

    def test_missing_list_item_reports_length_without_hiding_shared_changes(self):
        differences = walk({"Mission": {"values": [1, 2]}}, {"Mission": {"values": [1, 3, 4]}})
        self.assertEqual([item["path"] for item in differences], [
            "root.Mission.values.length",
            "root.Mission.values[1]",
        ])


if __name__ == "__main__":
    unittest.main()