extends Control

# 爱丽房间参数
# 玩家点击白
export var white_get_known_by_eli:bool = false
# 玩家点击日记本
export var diary_readed:bool = false
# 玩家可以从窗户逃脱
func eli_escape_from_room()->bool:
	return diary_readed

# 爱丽回到公路并自由活动
export var eli_get_free_on_road:bool = false

# 树洞小屋参数
# 爱丽知道树洞小屋
export var home_of_treehole_get_known_by_eli:bool = false
# 爱丽从树洞小屋中的屋顶梦境中醒来
export var eli_wakeup_from_rooftop:bool = false
# 爱丽准备去学校
export var eli_is_going_to_school:bool = false
# 爱丽准备去找黑
export var eli_is_going_to_find_black:bool = false

# 爱丽可以访问学校
func school_avalible()->bool:
	return eli_is_going_to_school

# 爱丽到达公园并自由活动
export var eli_get_free_on_park:bool = false

# 爱丽到达步行街并自由活动
export var eli_get_free_on_pedestrian_street:bool = false

# 爱丽解决了争端并在仓库自由活动
export var eli_get_free_on_warehouse:bool = false

# 咖啡厅参数
# 爱到达咖啡厅并自由活动
export var eli_get_free_on_cafe:bool = false
# 获得咖啡豆
export var eli_get_coffee_bean:bool = false
# 黑不见了
export var black_disappear:bool = false

# 游戏结束
export var finished:bool = false

# 维护这个变量，实时显示当前场景 供 _event.csv 切换场景使用
export var current_scene:String = "touch_to_start"
export var scene_change_duration:float = 1
func change_scene_from_to(source_node:String, dest_node:String)->void:
	var sourceNode:Scene = get_node(source_node)
	var destNode:Scene = get_node(dest_node)
	destNode.raise()
	# warning-ignore:return_value_discarded
	get_tree().create_tween().tween_method(destNode, "set_modulate",
			Color(1,1,1,0), Color(1,1,1,1), scene_change_duration)
	$InputBlocker.set_visible(true)
	$InputBlocker.raise()
	destNode.visible = true
	current_scene = dest_node
	yield(get_tree().create_timer(scene_change_duration),"timeout")
	sourceNode.visible = false
	destNode.init()
	$InputBlocker.set_visible(false)
	return
