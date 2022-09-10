extends KinematicBody2D


var velocity: Vector2
var grounded: bool = false

export var speed = 2500
export var gravity = 500
export var jump_force = 9000
export var grid_size := 16

onready var anim = $AnimatedSprite
onready var floorcast = $FloorCast
onready var cursor = $Cursor

enum State{
	Idle,
	Walking,
}

var state = State.Idle

func _ready():
	pass
	
func _process(delta):
	move(delta)
	animate()
	position_cursor()
	
func move(delta):
	velocity.x = 0
	if Input.is_action_pressed("walk_right"): velocity.x += 1
	if Input.is_action_pressed("walk_left"): velocity.x -= 1
	
	if !floorcast.is_colliding():
		grounded = false
		velocity.y += gravity * delta
	else:
		if !grounded:
			land()
		grounded = true
		if Input.is_action_just_pressed("jump"):
			velocity.y = 0
			velocity.y -= jump_force * delta
	
	velocity.x = velocity.x * speed * delta
	move_and_slide(velocity)

func animate():
	if velocity.x > 0: 
		anim.flip_h = false
		anim.play("walk")
	elif velocity.x < 0:
		anim.flip_h = true
		anim.play("walk")
	elif velocity.x == 0:
		anim.play("idle")
	if !grounded:
		if velocity.y >= 0: anim.play("fall")
		else: anim.play("rise")

func land():
	pass
	
func position_cursor():
	var mouse_pos = get_viewport().get_mouse_position()
	var pos = Vector2(floor(mouse_pos.x / grid_size)*grid_size, floor(mouse_pos.y / grid_size)*grid_size)
	cursor.global_position = pos
	
	
