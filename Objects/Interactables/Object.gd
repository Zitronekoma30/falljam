extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("interactable")
	init()


func interact(item):
	if item != null:
		interaction_item(item)
	interaction_null()
	
#virtual
func init(): pass
func interaction_item(item): pass
func interaction_null(): pass
