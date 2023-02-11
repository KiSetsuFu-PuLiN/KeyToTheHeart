extends Node

var se_change_duration:float = 5
var current_se:Node = null
func play_se(se_name:String)->void:
	if current_se:
		# warning-ignore:return_value_discarded
		get_tree().create_tween().tween_property(current_se, "volume_db", -80.0, se_change_duration)
	var seNode:AudioStreamPlayer = AudioStreamPlayer.new()
	self.add_child(seNode)
	seNode.stream = load("res://resource/sound/se/%s"%se_name)
	seNode.play()
	current_se = seNode
	yield(seNode,"finished")
	seNode.queue_free()
	return

func play_bgm(bgm_path:String)->void:
	$"/root/Main/BGM".play_bgm(bgm_path)
	return
