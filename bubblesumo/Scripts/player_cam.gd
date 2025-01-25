extends Camera3D

@onready var player:RigidBody3D = $"../../PlayerBody"
@onready var camPivot:Node3D = $".."
var offset:Vector3
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	offset = self.global_position - player.position
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	self.global_position = player.global_position + offset
	if(Input.is_action_pressed("InputRight")):
		camPivot.rotate(Vector3.UP,-1*delta)
		#player.apply_force(Vector3.RIGHT*5)
	if(Input.is_action_pressed("InputLeft")):
		camPivot.rotate(Vector3.UP,1*delta)
		
	self.position = $"../Node3D".position
	self.rotation = $"../Node3D".rotation
	pass

func _physics_process(delta: float) -> void:
	if(Input.is_action_pressed("InputForward")):
		player.apply_force(-camPivot.transform.basis.z * 10)
	if(Input.is_action_pressed("InputBack")):
		player.apply_force(camPivot.transform.basis.z * 10)
	if(Input.is_action_pressed("Jump")):
		player.apply_force(Vector3.UP*20)
	camPivot.position = player.position
	#if(Input.is_action_pressed("InputRight")):
		#camPivot.rotate(Vector3.UP,0.1*delta)
		##player.apply_force(Vector3.RIGHT*5)
	#if(Input.is_action_pressed("InputLeft")):
		#camPivot.rotate(Vector3.UP,-0.1*delta)
		##player.apply_force(-Vector3.RIGHT*5)
	pass
