extends StaticBody3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func FIRE(ob:Node3D) -> void:
	if ob.has_method("apply_impulse"):
		ob.apply_impulse(-(self.position/4)+Vector3.UP*30)
