extends Node

#export var socket:String = "192.168.43.193:9080"
export var socket:String = "cn-zz-bgp-6.natfrp.cloud:17089"

var _client:StreamPeerTCP = StreamPeerTCP.new()

func _ready():
	set_process(false)

func ready():
	var __:Array = socket.split(":")
	var address:String = __[0]
	var port:int = int(__[1])
	var err := _client.connect_to_host(address, port)
	if err:
		push_warning("Client Connect Error, Code: %d"%err)
		connect_failed = true
	else:
		print_debug("Client Connect Successfully")
		set_process(true)
	return

# warning-ignore:unused_argument
func _process(delta):
	if not _client.is_connected_to_host():
		set_process(false)
	if _client.get_available_bytes():
		handle_data(_client.get_var())
	return

func handle_data(data)->void:
	print_debug("Receive Data: ",data)
	match data:
		{"rank":var rank,"total":var total}:
			$"/root/Main".rank = data["rank"]
			$"/root/Main".total = data["total"]
			$"/root/Main".rank = $"/root/Main".total-$"/root/Main".rank
			connect_failed = false
		_:
			push_warning("Server In ERROR")
	return

var connect_failed:bool = true
func push_data(data, depth:int = 0)->void:
	if depth >= 10:
		connect_failed = true
		print_debug("Connect Failed, Give Up to connect.")
		return
	match _client.get_status():
		StreamPeerTCP.STATUS_CONNECTED:
			print_debug("SSL in Use, Server Online")
			_client.put_var(data)
			print_debug("Send Data: ",data)
		StreamPeerTCP.STATUS_CONNECTING:
			print_debug("TCP in Use, Server May not Enable")
			yield(get_tree().create_timer(0.5),"timeout")
			push_data(data, depth+1)
		StreamPeerTCP.STATUS_ERROR:
			push_error("Server Connected in ERROR")
		StreamPeerTCP.STATUS_NONE:
			print_debug("Server Not Connected, Server May Closed")
			print_debug("Try Connecting & Waiting & ReSend Data")
			ready()
			push_data(data, depth+1)
	return

#######################弃用的WebSocket写法##########################
## 目标Socket
##export var url:String = "127.0.0.1:9080"
##export var url:String = "cn-zz-bgp-6.natfrp.cloud:17089"
#export var url:String = "ctos-wlan.ddnsto.com:443"
##export var url:String = "https://192.168.43.52:9080"
## 客户端实例
#var _client:WebSocketClient = WebSocketClient.new()
#func _ready():
#	# 客户端实例各信号连接到本地函数
#	# warning-ignore:return_value_discarded
#	_client.connect("connection_closed", self, "_closed")
#	# warning-ignore:return_value_discarded
#	_client.connect("connection_error", self, "_closed")
#	# warning-ignore:return_value_discarded
#	_client.connect("connection_established", self, "_connected")
#	# warning-ignore:return_value_discarded
#	_client.connect("data_received", self, "_on_data")
#	# 连接失败
#	var err = _client.connect_to_url(url)
#	if err != OK:
#		push_error("连接服务端失败")
#		set_process(false)
#func _closed(was_clean:bool = false):
#	print("连接已关闭, 状态校验:", was_clean)
#	set_process(false)
#func _connected(protocol:String = ""):
#	print("连接成功，使用协议：", protocol)
#func _on_data():
#	received_data = _client.get_peer(1).get_packet().get_string_from_utf8()
#	print("接收到服务端消息：", received_data)
## warning-ignore:unused_argument
#func _process(delta):
#	# 持续拉取消息以激活客户端实例的信号
#	_client.poll()
#
## 接受的数据
#var received_data:String
#func push_text(text:String)->bool:
#	print("发送数据：",text)
#	if _client.get_connection_status() == NetworkedMultiplayerPeer.CONNECTION_CONNECTED:
#		if _client.get_peer(1).put_packet(text.to_utf8()):
#			push_error("数据发送失败")
#	else:
#		push_error("网络连接不正确，数据未发送")
#	return true
