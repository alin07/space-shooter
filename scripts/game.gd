extends Node2D

@onready var player_spawn = $PlayerSpawnPos
@onready var laser_container = $LaserContainer

var player = null
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")
	player.global_position = player_spawn.global_position
	player.laser_shot.connect(_on_player_laser_shot)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()
	elif  Input.is_action_just_pressed("reset"):
		get_tree().reload_current_scene()
	pass

func _on_player_laser_shot(laser_scene, location):
	var laser = laser_scene.instantiate()
	#location.y -= 75
	laser.global_position = location
	laser_container.add_child(laser)
