extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("interactable")

func interact(item):
	if item != null:
		print("YOU INTERACTED WITH ME " + item.name)
	print("no item")
