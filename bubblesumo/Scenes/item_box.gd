extends Node3D

var rot_timer = 0
var player
var play_timer = 0
var option = 0
@onready var icons = [preload("res://Textures/icon-speed.png"),preload("res://Textures/icon-mass.png"),preload("res://Textures/icon-grow.png")]
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
		
		match (option):
			0:
				player.camAccess.speed = 15
				player.Icon.texture = icons[0]
				player.IconText.text = "Speed"
			1:
				player.mass = 1.5
				player.Icon.texture = icons[1]
				player.IconText.text = "Weight"
			2:
				player.scale = Vector3(1.5, 1.5, 1.5)
				player.set_colliderScale(1.5)
				player.Icon.texture = icons[2]
				player.IconText.text = "Scale"
	elif (player != null):
		match (option):
			0:
				player.camAccess.speed = 10
			1:
				player.mass = 1
			2:
				player.scale = Vector3(1, 1, 1)
				player.set_colliderScale(1)
		player.Icon.texture = null
		player.IconText.text = ""
		player = null
	else:
		show()

func FIRE(ob:Node3D) -> void:
	if (not play_timer > 0 and ob.has_method("apply_impulse")):
		var rng = RandomNumberGenerator.new()
		option =  rng.randi_range(0, 2)
		player = ob
		play_timer = 20
