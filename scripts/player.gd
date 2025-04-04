class_name Player extends CharacterBody2D

@export var rate_of_fire := 0.25

const SPEED_X = 600.0
const SPEED_Y = 500.0
const JUMP_VELOCITY = -400.0

signal laser_shot(laser_scene, location)
var laser_scene = preload("res://scenes/laser.tscn")

@onready var muzzle = $Muzzle

var shoot_cd := false


func _process(delta: float) -> void:
	if Input.is_action_pressed("shoot"):
		if !shoot_cd:
			shoot_cd = true
			shoot()
			await get_tree().create_timer(rate_of_fire).timeout
			shoot_cd = false

func _physics_process(delta: float) -> void:
	var direction := Vector2(Input.get_axis("move_left","move_right"), 
							 Input.get_axis("move_up","move_down"))
	if direction:
		velocity.x = direction.x * SPEED_X
		velocity.y = direction.y * SPEED_Y
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED_X)
		velocity.y = move_toward(velocity.y, 0, SPEED_Y)
	move_and_slide()
	global_position = global_position.clamp(Vector2.ZERO, get_viewport_rect().size)
	
func shoot() -> void:
	laser_shot.emit(laser_scene, muzzle.global_position)
	
func die() -> void:
	queue_free()
