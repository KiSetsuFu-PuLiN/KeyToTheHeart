extends Control

# 存储还应当进行的对话
export var dialog_event_list:Array = []

func _ready():
	dialog_event_list = []
	pop_dialog()
	pass

# 激活Dialog并更新对话
func start_dialog_event(event:Array)->void:
	dialog_event_list = event
	self.set_visible(true)
	self.set_process_input(true)
	pop_dialog()
	return

# 在点击时更新对话
func _input(event):
	if event is InputEventMouseButton:
		if not event.pressed:
			pop_dialog()

# 更新对话的细节操作
func pop_dialog()->void:
	# 在空对话时停止本节点
	if dialog_event_list.empty():
		self.set_visible(false)
		self.set_process_input(false)
		$Tachie.set_tachie("")
		$Text.set_name("")
		$Text.set_text("")
		GameControl.stop_cg()
		GameControl.emit_signal("dialog_finished")
	# 否则就翻译文本并继续对话
	else:
		var dialog_dict:Dictionary = dialog_event_list.pop_front()
		$Tachie.set_tachie(dialog_dict['立绘'])
		$Text.set_name(GlobalTranslation.translate(dialog_dict['人物']))
		$Text.set_text(GlobalTranslation.translate(dialog_dict['文本']))
		if 'CG' in dialog_dict:
			GameControl.start_cg(dialog_dict['CG'])
		if 'SE' in dialog_dict:
			if dialog_dict['SE']:
				AudioControl.play_se(dialog_dict['SE'])
	return
