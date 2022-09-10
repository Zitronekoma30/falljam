extends RigidBody2D
##item factory as well as visual rep for items

export(String, "pumpkin", "eggplant") var item_name

var item_path = "res://Resources/Item.tres"
var item_instance

onready var sprite = $Sprite
onready var anim = $AnimationPlayer

func _ready():
	add_to_group("items")
	item_instance = create_item(item_name)
	if item_instance != null: sprite.texture = item_instance.sprite

func create_item(_item_name):
	var item = load(item_path)
	if _item_name == "pumpkin":
		item.name = _item_name
		item.sprite = load("res://Assets/Pumpkin.png")
		item.value = 15
		item.stackable = true
		item.max_stack = 10
		item.stack = 1
	elif _item_name == "eggplant":
		item.name = _item_name
		item.sprite = load("res://Assets/Eggplant.png")
		item.value = 20
		item.stackable = true
		item.max_stack = 5
		item.stack = 1
	else:
		return null
	return item

func pickup():
	anim.play("pickup")
	yield(anim, "animation_finished")
	queue_free()
