extends "res://Objects/Interactables/Object.gd"

onready var s_acre = $Sprite

export var tilled = false

func init():
	s_acre.visible = tilled

func interaction_item(item):
	print("ey")
	if item.name == "hoe":
		set_tilled(!tilled)
		
func interaction_null(): pass

func set_tilled(_tilled):
	tilled = _tilled
	if tilled: s_acre.visible = true
	else: s_acre.visible = false
