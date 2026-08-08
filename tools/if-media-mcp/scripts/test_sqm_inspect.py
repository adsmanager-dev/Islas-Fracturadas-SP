import unittest
from pathlib import Path
import sys

sys.path.insert(0, str(Path(__file__).parent))
from sqm_inspect import flatten_entities, build_summary


class FlattenEntitiesTests(unittest.TestCase):
    def test_flat_object_with_position_and_name(self):
        entities = {
            "items": 1,
            "Item0": {
                "dataType": "Object",
                "type": "B_Boat_Transport_01_F",
                "side": "West",
                "PositionInfo": {"position": [100.0, 5.0, 200.0]},
                "Attributes": {"name": "IF_BLUE_BOAT_01"},
                "id": 42,
            }
        }
        flat = flatten_entities(entities)
        self.assertEqual(len(flat), 1)
        e = flat[0]
        self.assertEqual(e["type"], "B_Boat_Transport_01_F")
        self.assertEqual(e["name"], "IF_BLUE_BOAT_01")
        self.assertEqual(e["position"], [100.0, 5.0, 200.0])
        self.assertEqual(e["id"], 42)

    def test_group_children_inherit_side_when_missing(self):
        entities = {
            "items": 1,
            "Item0": {
                "dataType": "Group",
                "side": "West",
                "Entities": {
                    "items": 1,
                    "Item0": {"dataType": "Object", "type": "B_Soldier_F", "id": 1}
                }
            }
        }
        flat = flatten_entities(entities)
        by_type = {e["data_type"]: e for e in flat}
        self.assertEqual(by_type["Object"]["side"], "West")

    def test_explicit_side_overrides_inherited_side(self):
        entities = {
            "items": 1,
            "Item0": {
                "dataType": "Group",
                "side": "West",
                "Entities": {
                    "items": 1,
                    "Item0": {"dataType": "Object", "side": "East", "type": "O_Soldier_F", "id": 2}
                }
            }
        }
        flat = flatten_entities(entities)
        obj = [e for e in flat if e["data_type"] == "Object"][0]
        self.assertEqual(obj["side"], "East")

    def test_real_init_field_is_captured(self):
        entities = {
            "items": 1,
            "Item0": {
                "dataType": "Object",
                "Attributes": {"init": "[] call IF_fnc_real;"}
            }
        }
        flat = flatten_entities(entities)
        self.assertEqual(flat[0]["init"], "[] call IF_fnc_real;")

    def test_no_position_info_yields_none_not_crash(self):
        entities = {"items": 1, "Item0": {"dataType": "Logic", "type": "ModuleCurator_F"}}
        flat = flatten_entities(entities)
        self.assertIsNone(flat[0]["position"])


class SummaryTests(unittest.TestCase):
    def test_counts_and_named_index(self):
        flat = [
            {"path": "Item0", "data_type": "Object", "side": "West", "name": "IF_BLUE_FOB", "init": None},
            {"path": "Item1", "data_type": "Object", "side": "West", "name": None, "init": "[] call IF_fnc_x;"},
            {"path": "Item2", "data_type": "Marker", "side": None, "name": None, "init": None},
        ]
        summary = build_summary(flat)
        self.assertEqual(summary["total_entities"], 3)
        self.assertEqual(summary["counts_by_data_type"], {"Marker": 1, "Object": 2})
        self.assertEqual(summary["counts_by_side"], {"West": 2})
        self.assertEqual(summary["named_entities"], {"IF_BLUE_FOB": "Item0"})
        self.assertEqual(summary["entities_with_init"], 1)


if __name__ == "__main__":
    unittest.main()
