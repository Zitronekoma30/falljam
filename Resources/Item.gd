extends Resource

var name: String
var sprite: StreamTexture
var value: int

var stackable: bool = false
var max_stack: int
var stack: int

func _init():
	print("initialized item: " + name)
