extends Control

var current_tachie:Node = null

func set_tachie(img_path:String)->void:
	var tachie:Node =  get_node_or_null(img_path)
	if tachie == current_tachie:
		return
	if current_tachie:
		current_tachie.visible = false
	if not tachie:
		current_tachie = null
		return
	tachie.visible = true
	current_tachie = tachie
	return
