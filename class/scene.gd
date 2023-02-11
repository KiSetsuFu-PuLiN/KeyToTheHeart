extends Node2D
class_name Scene

func init()->void:
	# virtual
	return

# 将自身的场景进行更换
func change_background(name:String)->void:
	#print_debug("切换背景：%s"%name)
	for node in $background.get_children():
		if node.name == name:
			node.visible = true
		else:
			node.visible = false
	return

func change_scene(scene_name:String)->void:
	$"..".change_scene_from_to(self.name,scene_name)
	return
func start_dialog_event(event:String)->void:
	GameControl.start_dialog_event(event)
	return
func start_screen_effect_event(event:String)->void:
	GameControl.start_screen_effect_event(event)
	return
func start_event(event:String)->void:
	GameControl.start_event(event)
	return
func add_item(item_name:String, item_Texture_name:String):
	GameControl.add_item(item_name, load("res://resource/image/item/%s"%item_Texture_name))
	return
func remove_item(item_name:String):
	GameControl.remove_item(item_name)
	return
func play_bgm(bgm:String)->void:
	AudioControl.play_bgm(bgm)
	return
