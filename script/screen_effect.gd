extends Control

func start_screen_effect_event(screen_effect_event:String)->void:
	var screen_effect_node:Node = get_node(screen_effect_event)
	assert(screen_effect_node,"动画子节点不存在\n接收到：%s\n实际可用：%s\n"%[screen_effect_event, JSON.print(self.get_children())])
	screen_effect_node.set_visible(true)
	screen_effect_node.start()
	return
