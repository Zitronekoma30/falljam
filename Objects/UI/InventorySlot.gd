extends TextureRect


export var selected := false 
var a_sprite = preload("res://Assets/SlotSelected.png")
var i_sprite = preload("res://Assets/Slot.png")

onready var item_tex = $Item
onready var stack = $StackCount

signal item_gone

var item

func _ready():
	set_selected(selected)
	
func _process(delta):
	if item != null:
		stack.text = str(item.stack)
		if item.stack <= 0: 
			emit_signal("item_gone", self)
			set_item(null)

func set_selected(new: bool):
	if new: texture = a_sprite
	else: texture = i_sprite
	selected = new
	
func set_item(_item):
	item = _item
	if _item == null:
		stack.visible = false
		item_tex.texture = null
		return
	item_tex.texture = _item.sprite
	stack.visible = true
