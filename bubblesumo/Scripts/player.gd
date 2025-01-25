extends RigidBody3D

var startingpos:Vector3

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	startingpos = position
	pass # Replace with function body.

func died() -> void:
	self.position = startingpos
	self.linear_velocity = Vector3.ZERO
	self.angular_velocity = Vector3.ZERO
	GlobalScore.P2_Score += 1
	$"../Control/Scoreval".text = str(GlobalScore.P1_Score)
	$"../Control/Scoreval2".text = str(GlobalScore.P2_Score)
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(global_position.y < -30):
		died()
