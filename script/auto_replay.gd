extends AudioStreamPlayer

func _ready():
	assert(not connect("finished",self,"_on_play_finished"),"信号连接失败")
	return

func _on_play_finished():
	play()
	return
