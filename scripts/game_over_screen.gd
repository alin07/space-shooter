extends Control

#@onready var 


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_reset_button_pressed() -> void:
	get_tree().reload_current_scene()

func set_score(value: int) -> void:
	$ColorRect/Panel/Score.text = "Score: " + str(value)
	
func set_hi_score(value: int) -> void:
	$ColorRect/Panel/HiScore.text = "Hi Score: " + str(value)
