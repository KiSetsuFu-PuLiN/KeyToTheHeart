extends ColorRect

"""
制作人员：
勤杂：蒲灵
文案：斑斑

感谢
Godot、Krita、GIMP等等开源社区 提供免费且强大的开发软件
Godot中国社区朋友们的贴心技术指导

"""
var just_talk:bool = true
func _on_Exit_pressed():
	if $"/root/Main/Puzzle".finished and just_talk:
		var event:Array = [
				{
						"人物":"蒲灵",
						"立绘":"pulin",
						"文本":"很高兴你能游玩我们的游戏",
				},
				{
						"人物":"蒲灵",
						"立绘":"pulin",
						"文本":"好吧，说实话，作为这个游戏的开发者之一，我也并不满意作品当前的质量",
				},
				{
						"人物":"蒲灵",
						"立绘":"pulin",
						"文本":"制作人员和时间都十分有限，美术和各方面也太拉胯了…………",
				},
				{
						"人物":"蒲灵",
						"立绘":"pulin",
						"文本":"不过，这确实也是我们第一次尝试制作游戏，也是第一次熟悉合作下的游戏制作流程、处理开发中的各种问题",
				},
				{
						"人物":"蒲灵",
						"立绘":"pulin",
						"文本":"但无论如何，所有的事情总得先去尝试，多去实践才有可能更进一步嘛",
				},
				{
						"人物":"蒲灵",
						"立绘":"pulin",
						"文本":"我们会期待与你的下一次见面，在更加优秀的游戏作品之中",
				},
				{
						"人物":"蒲灵",
						"立绘":"pulin",
						"文本":"再次感谢您的游玩",
				},
				{
						"人物":"蒲灵",
						"立绘":"pulin",
						"文本":"…………",
				},
				{
						"人物":"蒲灵",
						"立绘":"pulin",
						"文本":"对了，其实这个游戏也有一点点联网的功能2333，也纯粹是我自己瞎折腾弄出来的",
				},
				{
						"人物":"蒲灵",
						"立绘":"pulin",
						"文本":"整个游戏中有两个小游戏，我有对你的操作做些记录",
				},
				{
						"人物":"蒲灵",
						"立绘":"pulin",
						"文本":"在“弹幕躲避”的游戏中，你的分数为：%d\n在“挥舞打击”的游戏中，你的得分为：%d"%[$"/root/Main".Avoid,$"/root/Main".Fight],
				},
				{
						"人物":"蒲灵",
						"立绘":"pulin",
						"文本":"让我看看…………",
				},
				{
						"人物":"蒲灵",
						"立绘":"pulin",
						"文本":"看起来网络并没有成功连接……很遗憾呢" if Client.connect_failed else "在所有的玩家中，你的总分数排名为%d，超过了%.2f%%的玩家"%[
								$"/root/Main".rank,
								#(1 - ($"/root/Main".rank-1)/($"/root/Main".total-1.0))*100 if $"/root/Main".total>1 else 100,
								range_lerp($"/root/Main".rank,1,$"/root/Main".total,100,0),
						],
				},
				{
						"人物":"蒲灵",
						"立绘":"pulin",
						"文本":"好吧，就是这些",
				},
				{
						"人物":"蒲灵",
						"立绘":"pulin",
						"文本":"有缘再会了~",
				},
		]
		$"/root/Main/Dialog".start_dialog_event(event)
		just_talk = false
	set_visible(false)
	return

func _notification(what):
	match what:
		# 阻止关闭游戏，返回菜单
		NOTIFICATION_WM_QUIT_REQUEST:
			self.set_visible(false)
		# 阻止关闭游戏，返回菜单
		NOTIFICATION_WM_GO_BACK_REQUEST:
			self.set_visible(false)
