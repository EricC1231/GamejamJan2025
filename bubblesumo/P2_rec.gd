extends RigidBody3D

var input:Vector2 = Vector2.ZERO
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _physics_process(delta: float) -> void:
	if(GlobalScore.colledtedBuffer == false):
		var pos:Vector3 = Vector3(GlobalScore.recievedData[0],GlobalScore.recievedData[1],GlobalScore.recievedData[2])
		var vel:Vector3 = Vector3(GlobalScore.recievedData[3],GlobalScore.recievedData[4],GlobalScore.recievedData[5])
		var score:int = roundi(GlobalScore.recievedData[6])
		GlobalScore.P1_Score = score
		global_position = pos
		linear_velocity = vel
		GlobalScore.colledtedBuffer = true
	pass
