extends Resource
class_name MonsterTemplate

export var species: String
export var index: int

export(String, "fire", "water", "something") var type1
export(String, "fire", "water", "something") var type2

export var base_hp: int

func _init(): pass
