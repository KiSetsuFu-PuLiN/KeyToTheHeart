extends Control

var current_cg:String = ""
export var cg_change_duration:float = 1
func start_cg(cg:String)->void:
	if cg==current_cg:
		# CG无变化，不处理
		pass
	else:
		# CG有变化
		if cg:
			var cgNode:TextureRect = get_node(cg)
			cgNode.raise()
			# warning-ignore:return_value_discarded
			get_tree().create_tween().tween_method(cgNode, "set_modulate",
					Color(1,1,1,0), Color(1,1,1,1), cg_change_duration)
			cgNode.visible = true
			if current_cg:
				stop_cg_delay(current_cg, cg_change_duration)
			else:
				pass
		else:
			# warning-ignore:return_value_discarded
			get_tree().create_tween().tween_method(get_node(current_cg), "set_modulate",
					Color(1,1,1,1), Color(1,1,1,0), cg_change_duration)
			stop_cg_delay(current_cg, cg_change_duration)
		current_cg = cg
	return

func stop_cg_delay(cg:String, time:float)->void:
	yield(get_tree().create_timer(time),"timeout")
	stop_cg_immediately(cg)
	get_node(cg).modulate = Color(1,1,1,1)
	return

func start_cg_immediately(cg:String):
	get_node(cg).visible = true
	get_node(cg).modulate = Color(1,1,1,1)
	current_cg = cg
	return
func stop_cg_immediately(cg:String):
	get_node(cg).visible = false
	return

