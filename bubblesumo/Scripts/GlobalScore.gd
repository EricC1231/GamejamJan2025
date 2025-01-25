extends Node

var P1_Score:int = 0
var P2_Score:int = 0
var colledtedBuffer:bool = true
var dataBuffer:PackedFloat32Array

var rdc:bool = true
var recievedData:PackedFloat32Array

func SendData(data:PackedFloat32Array):
	dataBuffer = data
	rdc = false

func _process(delta: float) -> void:
	if(rdc == false):
		recievedData = dataBuffer
		rdc = true
		colledtedBuffer = false
