extends Node


var monsters_path = "res://Resources/Monsters/"
var dir = Directory.new()
onready var monster_list: Array = []



func _ready():
	dir.open(monsters_path)
	dir.list_dir_begin()
	while true:
		var filename = dir.get_next()
		if filename == "": break
		elif !filename.begins_with("."):
			monster_list.append(load(monsters_path + filename))
		
	print(monster_list)
	print(monster_list[0].species)
	print(monster_list[1].species)
	print(monster_list[2].species)
