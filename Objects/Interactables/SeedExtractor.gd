extends "res://Objects/Interactables/Object.gd"

var item_scn = preload("res://Objects/Item.tscn")

func interaction_item(item): 
	var seeds = null
	match item.name:
		"pumpkin": seeds = "pumpkin_seeds"
		"eggplant": seeds = "eggplant_seeds"
	if seeds != null:
		item.stack -= 1
		var new_item = item_scn.instance()
		new_item.set_item(seeds)
		get_tree().get_root().add_child(new_item)
		new_item.global_position = global_position

func interaction_null(): pass
