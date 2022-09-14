extends Resource
class_name Item

var name: String
var sprite: Texture
var value: int

var max_stack: int
var stack: int

func _init():
	print("initialized item: " + name)
