extends Node

var enabled:bool = false;
var isServer:bool = false;
var GlobTime:float = 0;

var Effects:Array[String] = []

var P1_Score:int = 0
var P2_Score:int = 0
var colledtedBuffer:bool = true
var dataBuffer:PackedFloat32Array
var isBounce:bool = false


var p2:RigidBody3D
var rdc:bool = true
var recievedData:PackedFloat32Array

var cli:WebSocketMultiplayerPeer = WebSocketMultiplayerPeer.new()
#var peer:WebSocketPeer = WebSocketPeer.new()

func SendData(data:PackedFloat32Array):
	sendPacket(data.to_byte_array())
	#dataBuffer = data
	#rdc = false

func _ready() -> void:
	set_process(false)
	print(get_hostName())

func _process(delta: float) -> void:
	#if(rdc == false):
		#sendPacket(dataBuffer.to_byte_array())
		#rdc = true
	cli.poll()
	if(cli.get_available_packet_count() > 0):
		recievedData = cli.get_packet().to_float32_array()
		#print(cli.get_packet().get_string_from_ascii())
		#var data = bytes.get_string_from_ascii()
		#recievedData = data
		#print(data);
		colledtedBuffer = false
	pass



func get_local_ip() -> String:
	var ip = ""
	for addresses in IP.get_local_addresses():
		if(addresses.begins_with("192.168.") or addresses.begins_with("10.")):
			ip = addresses
			print(ip);
			return ip;
			break
	return ""

func get_hostName()->String:
	print("hi")
	var ip_adress :String
	var arr:Array = []

	print(OS.execute("hostname",[],arr))
	print(arr)

	print(IP.resolve_hostname(arr[0].rstrip('\n')))
	return arr[0]


func setupServer()-> String:
	cli.create_server(30010, get_local_ip())
	#multiplayer.multiplayer_peer = cli
	enabled = true;
	isServer = true;
	set_process(true)
	return get_local_ip()
	
func setupClient(ip:String):
	if(ip == ""):
		cli.create_client("ws://" + get_local_ip()+":30010")
	else:
		cli.create_client("ws://"+ip+":30010")
	#cli.create_client("ws://127.0.0.1:8915")
	var state := cli.get_connection_status()
	while state == cli.CONNECTION_CONNECTING:
		state = cli.get_connection_status()
		cli.poll();
	#multiplayer.multiplayer_peer = cli
	#cli.put_packet("hello world".to_ascii_buffer())
	set_process(true)
	enabled = true;
	pass
	
func setupClientByHostName(hostname:String):
	if(hostname == ""):
		cli.create_client("ws://" + get_local_ip()+":30010")
	else:
		cli.create_client("ws://"+IP.resolve_hostname(hostname)+":30010")
	var state := cli.get_connection_status()
	while state == cli.CONNECTION_CONNECTING:
		state = cli.get_connection_status()
		cli.poll();
	
	#if state == cli.CONNECTION_CONNECTED:
		#cli.put_packet("hello".to_ascii_buffer())
	#else:
		#print("Failed to connect!")
	set_process(true)
	enabled = true;
	pass


func sendPacket(pack:PackedByteArray):
	#var packet = pack.to_ascii_buffer()
	#broadcaster.put_packet(packet)
	if(cli.put_packet(pack) == ERR_UNCONFIGURED):
		print("disconected")
		set_process(false)
		enabled = false
		cleanUp()
		return;

func cleanUp():
	cli.close()

func _exit_tree():
	cleanUp()
