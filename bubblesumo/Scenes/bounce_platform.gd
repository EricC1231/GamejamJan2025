extends StaticBody3D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func FIRE(ob:Node3D) -> void:
	if ob.has_method("apply_impulse"):
		ob.apply_impulse(Vector3(0, 20, 0))
