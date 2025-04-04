extends Node2D
@export var enemy_scenes: Array[PackedScene] = []

@onready var player_spawn = $PlayerSpawnPos
@onready var laser_container = $LaserContainer
@onready var timer = $EnemySpawnTimer
@onready var enemy_container = $EnemyContainer
@onready var hud = $UILayer/HUD
@onready var gos = $UILayer/GameOverScreen

var player = null
var score := 0:
	set(value):
		score = value
		hud.score = score
var hi_score

const hi_score_file = "user://save.data"

func _ready() -> void:
	var save_file = FileAccess.open(hi_score_file, FileAccess.READ)
	if save_file != null:
		hi_score = save_file.get_32()
	else:
		hi_score = 0
	gos.visible = false
	player = get_tree().get_first_node_in_group("player")
	player.global_position = player_spawn.global_position
	player.laser_shot.connect(_on_player_laser_shot)
	player.killed.connect(_on_player_killed)

func save_game() -> void:
	var save_file = FileAccess.open(hi_score_file, FileAccess.WRITE)
	save_file.store_32(hi_score)

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()
	elif  Input.is_action_just_pressed("reset"):
		get_tree().reload_current_scene()
	pass

func _on_player_laser_shot(laser_scene, location):
	var laser = laser_scene.instantiate()
	laser.global_position = location
	laser_container.add_child(laser)


func _on_enemy_spawn_timer_timeout() -> void:
	var e = enemy_scenes.pick_random().instantiate()
	e.global_position = Vector2(randf_range(50, 1000), -100)
	e.killed.connect(_on_enemy_killed)
	enemy_container.add_child(e)

func _on_enemy_killed(points: int) -> void:
	score += points
	if (score > hi_score):
		hi_score = score

func _on_player_killed() -> void:
	gos.set_score(score)
	gos.set_hi_score(hi_score)
	save_game()
	await get_tree().create_timer(1.5).timeout
	gos.visible = true
