extends Resource
class_name Item

export var name: String
export var sprite: Texture
export var value: int
export var sellable: bool

export var max_stack: int
export var stack: int

func _init():
	#print("initialized item: " + name)
	pass
