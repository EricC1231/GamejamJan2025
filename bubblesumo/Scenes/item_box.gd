extends Node3D

var rot_timer = 0
var player
var play_timer = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	rot_timer += delta
	
	self.rotate_x(1*delta)
	self.rotate_y(3*delta)
	self.rotation.z = (8*sin(1*rot_timer))

func _physics_process(delta):
	if play_timer > 0:
		hide()
		play_timer -= delta
		var rng = RandomNumberGenerator.new()
		var option =  rng.randi_range(0, 2)
		
		match (option):
			0:
				pass
			1:
				pass
			2:
				pass
	else:
		show()

func FIRE(ob:Node3D) -> void:
	if (true and not play_timer > 0):
		player = ob
		play_timer = 20
