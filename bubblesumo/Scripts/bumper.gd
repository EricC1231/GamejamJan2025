extends StaticBody3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _on_bumper_bumpback_body_entered(ob: Node3D) -> void:
	if ob.has_method("apply_impulse"):
		ob.apply_impulse((self.global_position - ob.global_position).normalized() * 90)
	pass # Replace with function body.
