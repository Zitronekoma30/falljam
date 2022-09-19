extends "res://Objects/Interactables/Object.gd"

var item_scn = preload("res://Objects/Item.tscn")
var filled = false

onready var crop = $CropSprite
onready var anim = $AnimationPlayer

func interaction_item(item):
	var seeds = null
	match item.name:
		"pumpkin": seeds = "pumpkin_seeds"
		"eggplant": seeds = "eggplant_seeds"
	if seeds != null and !filled:
		filled = true
		crop.texture = item.sprite
		anim.play("Shred")
		yield(anim, "animation_finished")
		item.stack -= 1
		var new_item = item_scn.instance()
		new_item.set_item(seeds)
		get_tree().get_root().add_child(new_item)
		new_item.global_position = global_position
		filled = false
		anim.play("RESET")
		
func interaction_null(): pass
