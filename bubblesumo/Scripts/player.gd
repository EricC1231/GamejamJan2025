extends RigidBody3D

var startingpos:Vector3
var time:float = 300.0

var startingPoints:Array[Vector3] = [Vector3(-50,0,0),Vector3(50,0,0)]

@onready var camAccess = $"../CamPivot/PlayerCam"

var isBounce:bool = false

var ServerPollTime:float = 0.0

func set_colliderScale(s:float):
	$CollisionShape3D.shape.radius = s
	$Area3D/CollisionShape3D.shape.radius = s

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if(GlobalScore.isServer):
		self.global_position = startingPoints[0]
	else:
		self.global_position = startingPoints[1]
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
	if(ServerPollTime > 0.1 and GlobalScore.enabled):
		var bounce:float = 0.0
		if(isBounce):
			bounce = 1.0
			isBounce = false
		var arr:PackedFloat32Array = [self.global_position.x,self.global_position.y,self.global_position.z,
		self.linear_velocity.x,self.linear_velocity.y,self.linear_velocity.z, float(GlobalScore.P2_Score), time, bounce]
		GlobalScore.SendData(arr) 
		ServerPollTime = 0
		$"../Control/Scoreval".text = str(GlobalScore.P1_Score)
		if(!GlobalScore.isServer):
			time = GlobalScore.GlobTime
		if(GlobalScore.isBounce):
			self.apply_impulse(-(GlobalScore.p2.global_position-self.global_position).normalized()*20)
			GlobalScore.isBounce = false;
		
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


func _on_body_entered(body: Node3D) -> void:
	if(body.has_method("apply_impulse") and GlobalScore.isServer and body != self):
		self.apply_impulse(-(body.global_position-self.global_position).normalized()*20)
		isBounce = true
		
	pass # Replace with function body.
