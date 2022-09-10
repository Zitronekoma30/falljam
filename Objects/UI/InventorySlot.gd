extends TextureRect


export var selected := false 
var a_sprite = preload("res://Assets/SlotSelected.png")
var i_sprite = preload("res://Assets/Slot.png")

onready var item_tex = $Item

var item

func _ready():
	set_selected(selected)

func set_selected(new: bool):
	if new: texture = a_sprite
	else: texture = i_sprite
	selected = new
	
func set_item(_item):
	item = _item
	if _item == null:
		item_tex.texture = null
		return
	item_tex.texture = _item.sprite
