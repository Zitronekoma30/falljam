extends Control

onready var ui_inv = $Inventory
onready var ui_slots = ui_inv.get_children()
onready var cursor = $Cursor

export var player_path: NodePath
onready var player = get_node(player_path)

var grid_size = 16

onready var inv_size = ui_slots.size()
var inventory: Array = []

var selected = 0

func _ready():
	for i in range(inv_size):
		inventory.append(null)
	player.connect("got_item", self, "add_item")

func _process(delta):
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
	position_cursor()

func position_cursor():
	var mouse_pos = get_viewport().get_mouse_position()
	var pos = Vector2(floor(mouse_pos.x / grid_size)*grid_size, floor(mouse_pos.y / grid_size)*grid_size)
	cursor.global_position = pos

func add_item(item):
	for i in range(inventory.size()):
		if inventory[i] == null: 
			inventory[i] = item.item_instance
			item.pickup()
			ui_slots[i].set_item(inventory[i])
			break
