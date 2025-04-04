extends Control


func _on_reset_button_pressed() -> void:
	get_tree().reload_current_scene()

func set_score(value: int) -> void:
	$ColorRect/Panel/Score.text = "Score: " + str(value)
	
func set_hi_score(value: int) -> void:
	$ColorRect/Panel/HiScore.text = "Hi Score: " + str(value)
