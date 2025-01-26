extends StaticBody3D

var isAnim:bool = false
var time:float = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _process(delta: float) -> void:
	if(isAnim):
		time+=delta*4
		var t:float = time*2
		if t > 1:
			t = 1-(t-1)
		$whacka.scale = Vector3.ONE + Vector3.ONE*t/2
		if(time > 1):
			time = 0
			isAnim = false
	pass

func _on_bumper_bumpback_body_entered(ob: Node3D) -> void:
	if ob.has_method("apply_impulse"):
		ob.apply_impulse((self.global_position - ob.global_position).normalized() * 90)
		isAnim = true
		$AudioStreamPlayer.play()
	pass # Replace with function body.
