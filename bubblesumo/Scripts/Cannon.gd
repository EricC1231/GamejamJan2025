extends StaticBody3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func FIRE(ob:Node3D) -> void:
	if ob.has_method("apply_impulse"):
		const FORWARD_VEL = 10
		
		var HOW_LONG : float
		var Y_vel : float
		
		HOW_LONG = self.position.x / FORWARD_VEL
		Y_vel = ((0.5 * ob.get_gravity().y) * pow(HOW_LONG, 2)) / (HOW_LONG)
		
		var directional_launch = Vector3(FORWARD_VEL, Y_vel, 0)
		
		ob.apply_impulse(directional_launch)
