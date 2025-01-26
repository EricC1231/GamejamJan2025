extends RigidBody3D

var startingpos:Vector3
var time:float = 300.0

@onready var camAccess = $"../CamPivot/PlayerCam"

var ServerPollTime:float = 0.0
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
	$"../Control/Scoreval3".text = str(floori(time/60))+":"+str(floori(time)%60)
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	ServerPollTime +=delta
	if(ServerPollTime > 0.1):
		var arr:PackedFloat32Array = [self.global_position.x+10,self.global_position.y,self.global_position.z,
		self.linear_velocity.x,self.linear_velocity.y,self.linear_velocity.z, float(GlobalScore.P2_Score), time]
		GlobalScore.SendData(arr) 
		ServerPollTime = 0
		$"../Control/Scoreval".text = str(GlobalScore.P1_Score)
		if(!GlobalScore.isServer):
			time = GlobalScore.GlobTime
		
	time -= delta
	$"../Control/Scoreval3".text = str(floori(time/60))+":"+str(floori(time)%60)
	if(global_position.y < -30):
		died()


func _on_button_pressed() -> void:
	GlobalScore.setupServer()
	#GlobalScore.setupClient("")
	print(GlobalScore.get_hostName())
	pass # Replace with function body.


func _on_button_2_pressed() -> void:
	GlobalScore.setupClientByHostName($"../Control/LineEdit".text)
	pass # Replace with function body.
