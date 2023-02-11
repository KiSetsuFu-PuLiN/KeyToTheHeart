# 本节点提供游戏控制台功能
# 开启人物对话事件
# 标识人物对话结束
# 开启屏幕特殊效果事件
# 开启混合事件
# CG管理
# 物品管理
# 存档存取
# 网络存取

extends Node

# 在对话播放完后发出此信号，可能有节点正等着对话结束
# warning-ignore:unused_signal
signal dialog_finished
# 在屏幕事件完成后发出此信号，可能有节点正等着事件结束
# warning-ignore:unused_signal
signal screen_effect_finished

func start_dialog_event(dialog_event_name:String)->void:
	var dialog_event:Array = FileManager.get_dialog_event(dialog_event_name)
	$"/root/Main/Dialog".start_dialog_event(dialog_event)
	return
func start_screen_effect_event(screen_effect_event:String)->void:
	$"/root/Main/ScreenEffect".start_screen_effect_event(screen_effect_event)
	return

var event_list:Array
func start_event(event:String)->void:
	var root_path:String = "res://resource/csv_sheet/dialog_event_sheet/"
	event_list = FileManager.parse_csv_file( "%s%s.csv"%[root_path,event] )
	_pop_event()
	return
var current_event_type:String = ""
func _pop_event()->void:
	# 接受信号，断开并准备开始下一个事件
	if current_event_type:
		match current_event_type:
			"screen_effect":
				GameControl.disconnect("screen_effect_finished",self,"_pop_event")
			"dialog":
				GameControl.disconnect("dialog_finished",self,"_pop_event")
	if event_list:
		var event:Dictionary = event_list.pop_front()
		match event["类型"]:
			"screen_effect":
				current_event_type = "screen_effect"
				assert(not GameControl.connect("screen_effect_finished",self,"_pop_event"), "信号连接失败")
				GameControl.start_screen_effect_event(event["调用"])
			"dialog":
				current_event_type = "dialog"
				assert(not GameControl.connect("dialog_finished",self,"_pop_event"), "信号连接失败")
				GameControl.start_dialog_event(event["调用"])
			"change_scene":
				current_event_type = ""
				var Puzzle:Node = $"/root/Main/Puzzle"
				Puzzle.change_scene_from_to(Puzzle.current_scene, event['调用'])
	else:
		current_event_type = ""
	return
func start_cg(cg:String)->void:
	$"/root/Main/CG".start_cg(cg)
	return
func stop_cg()->void:
	$"/root/Main/CG".start_cg("")
	return
func start_cg_immediately(cg:String)->void:
	$"/root/Main/CG".start_cg_immediately(cg)
	return
func stop_cg_immediately(cg:String)->void:
	$"/root/Main/CG".stop_cg_immediately(cg)
	return

# 文本->编号 的映射
func item_dict(text:String)->int:
	var item_list:ItemList = $"/root/Main/UpMenu/ItemList"
	for i in range(item_list.get_child_count()):
		if item_list.get_item_text(i) == text:
			return i
	assert(false,"%s不在物品栏中"%text)
	return -1
func add_item(text:String, icon:Texture)->void:
	$"/root/Main/UpMenu/ItemList".add_item(text, icon, true)
	return
func remove_item(text:String)->void:
	$"/root/Main/UpMenu/ItemList".remove_item(item_dict(text))
	return
func get_selected_item()->String:
	var selected_index:int = $"root/Main/UpMenu".current_item_index
	if selected_index == -1:
		return ""
	else:
		return $"root/Main/UpMenu/ItemList".get_item_text(selected_index)

const save_path:String = "user://save.tscn"
func save_game()->void:
	# 注意，此种存取方式只有把变量export成节点属性才能被保存
	# 注意，高级变量例如列表等不会被保存！
	# 注意，普通的从属于脚本的变量本不会被保存！
	var game_node_save:PackedScene = PackedScene.new()
	assert(not game_node_save.pack(get_tree().get_root().get_children()[-1]), "主节点打包失败")
	assert(not ResourceSaver.save(save_path, game_node_save), "打包的主节点存储到文件失败")
	return
func load_game()->void:
	if ResourceLoader.exists(save_path):
		assert(not get_tree().change_scene(save_path), "读取并加载存档文件失败")
	else:
		push_warning("存档文件%s不存在，存档读取和节点替换未进行"%save_path)
	return
func remove_save()->void:
	if ResourceLoader.exists(save_path):
		var save_path_OS:String = save_path.replace("user:/",OS.get_user_data_dir())
		assert(not OS.move_to_trash(save_path_OS),"删除存档失败")
	return

var first_load = true
func auto_load()->void:
	if first_load:
		load_game()
		first_load = false
	else:
		print("自动加载已执行过一次，放弃自动加载")
	return

func net_work()->void:
	Client.push_data([
			"add_item",
			{
					"id":OS.get_unique_id(),
					"score":round($"/root/Main".Avoid + $"/root/Main".Fight),
			},
	])
	return
