extends Node

export var bgm_change_duration:float = 3
export var current_folder:String = ""
export var current_bgm_name:String = ""

func _ready():
	if current_folder and current_bgm_name:
		var path:String = "%s/%s"%[current_folder,current_bgm_name]
		current_folder = ""
		current_bgm_name = ""
		play_bgm(path)
	else:
		play_bgm("Unease/90_Atmospheric_F Minor")
	return

func play_bgm(bgm_path:String)->void:
	var folder_and_bgm:Array = bgm_path.split("/")
	assert(get_node(bgm_path),"BGM不存在，请检查路径：%s"%bgm_path)
	var folder:String = folder_and_bgm[0]
	var bgm_name:String = folder_and_bgm[1]
	if folder == current_folder:
		# 同文件夹下切换
		if bgm_name != current_bgm_name:
			# warning-ignore:return_value_discarded
			get_tree().create_tween().tween_property(get_node(folder).get_node(current_bgm_name),"volume_db",-80.0,bgm_change_duration)
			# warning-ignore:return_value_discarded
			get_tree().create_tween().tween_property(get_node(folder).get_node(bgm_name),"volume_db",0.0,bgm_change_duration)
	else:
		if current_folder:
			# 不同文件夹下切换
			for node in get_node(current_folder).get_children():
				# warning-ignore:return_value_discarded
				get_tree().create_tween().tween_property(node,"volume_db",-80.0,bgm_change_duration)
			yield(get_tree().create_timer(bgm_change_duration),"timeout")
			for node in get_node(folder).get_children():
				if node.name == bgm_name:
					node.volume_db = 0
				else:
					node.volume_db = -80
				node.play()
			for node in get_node(current_folder).get_children():
				node.disconnect("finished",node,"_on_play_finished")
				node.stop()
				yield(node,"finished")
				assert(not node.connect("finished",node,"_on_play_finished"), "信号重连失败")
		else:
			# 最初的播放
			for node in get_node(folder).get_children():
				if node.name == bgm_name:
					node.volume_db = 0
				else:
					node.volume_db = -80
				node.play()
	current_folder = folder
	current_bgm_name = bgm_name
	return
