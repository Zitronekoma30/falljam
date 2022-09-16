extends Control

var item_scene = preload("res://Objects/Item.tscn")

onready var ui_inv = $Inventory
onready var ui_slots = ui_inv.get_children()
onready var cursor = $Cursor

export var player_path: NodePath
onready var player = get_node(player_path)

var current_interactors := []

var grid_size = 16

onready var inv_size = ui_slots.size()
var inventory: Array = []

var selected = 0

func _ready():
	ui_slots[selected].set_selected(true)
	for slot in ui_slots:
		slot.connect("item_gone", self, "_on_item_gone")
	for i in range(inv_size):
		inventory.append(null)
	player.connect("got_item", self, "add_item")

func _process(delta):
	input()
	position_cursor()


func input():
	if Input.is_action_just_released("scroll_down"):
		ui_slots[selected].set_selected(false)
		selected += 1
		if selected > inv_size-1: selected = 0
		ui_slots[selected].set_selected(true)
	if Input.is_action_just_released("scroll_up"):
		ui_slots[selected].set_selected(false)
		selected -= 1
		if selected < 0: selected = inv_size-1
		ui_slots[selected].set_selected(true)
	
	#dropping
	var current_slot = inventory[selected]
	if Input.is_action_just_pressed("drop"):
		if current_slot != null:
			var new_item = item_scene.instance()
			new_item.set_item(current_slot.name)
			get_tree().get_root().add_child(new_item)
			new_item.global_position = player.item_spawn_pos.global_position
			current_slot.stack -= 1
			if current_slot.stack <= 0:
				inventory[selected] = null
				ui_slots[selected].set_item(null)
	if Input.is_action_just_pressed("interact"):
		for interactor in current_interactors:
			interactor.interact(inventory[selected])

func position_cursor():
	var mouse_pos = get_viewport().get_mouse_position()
	var pos = Vector2(floor(mouse_pos.x / grid_size)*grid_size, floor(mouse_pos.y / grid_size)*grid_size)
	cursor.global_position = pos

func add_item(item):
	for i in range(inventory.size()):
		if inventory[i] != null:
			if inventory[i].name == item.item_instance.name and inventory[i].stack + item.item_instance.stack <= inventory[i].max_stack:
				inventory[i].stack += item.item_instance.stack
				item.pickup()
				return
	for i in range(inventory.size()):
		if inventory[i] == null: 
			inventory[i] = item.item_instance
			item.pickup()
			ui_slots[i].set_item(inventory[i])
			break



func _on_Cursor_area_entered(area):
	if area.is_in_group("interactable"): current_interactors.append(area)

func _on_Cursor_area_exited(area):
	if area.is_in_group("interactable"): current_interactors.remove(current_interactors.find(area))

func _on_item_gone(slot):
	inventory[ui_slots.find(slot)] = null
