extends Control

func _on_crash_pressed() -> void:
	get_tree().quit()
	pass # Replace with function body.

func _on_quit_pressed() -> void:
	get_tree().quit()
	pass # Replace with function body.


func _on_join_pressed() -> void:
	if($VBoxContainer/LineEdit.text != ""):
		if(GlobalScore.setupClientByHostName($VBoxContainer/LineEdit.text)):
			get_tree().change_scene_to_file("res://main.tscn")
	pass # Replace with function body.

func _on_start_pressed() -> void:
	
	pass # Replace with function body.
	
func _process(delta: float) -> void:
	if(GlobalScore.enabled && GlobalScore.colledtedBuffer == false):
		get_tree().change_scene_to_file("res://main.tscn")
	pass
