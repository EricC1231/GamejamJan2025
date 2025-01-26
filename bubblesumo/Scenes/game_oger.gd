extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$ScoreLable.text = "you: " + str(GlobalScore.P1_Score)+ ", P2: " +str(GlobalScore.P2_Score)
	if(GlobalScore.P1_Score > GlobalScore.P2_Score):
		$WinnerLable.text = "You Win!"
	if(GlobalScore.P1_Score == GlobalScore.P2_Score):
		$WinnerLable.text = "Tie!"
	if(GlobalScore.P1_Score < GlobalScore.P2_Score):
		$WinnerLable.text = "You Loose"
	
	pass # Replace with function body.

func quit():
	get_tree().quit()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_replay_pressed() -> void:
	get_tree().change_scene_to_file("res://main.tscn")
	pass # Replace with function body.
