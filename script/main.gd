extends Control

# 调试
func _ready():
	pass

# 设置表，在这里存储一系列的设置
export var language:String = "简体中文"

# 自动加载标记，游戏将会自动尝试加载已有的存档
export var AUTOLOAD:bool = true

# 游戏分数
export var Avoid:float = 0
export var Fight:float = 0
# 网络数据
export var rank:int = 0
export var total:int = 0

func _enter_tree():
	# 阻止游戏被 返回键/关闭键 时直接关闭
	get_tree().set_quit_on_go_back(false)
	get_tree().set_auto_accept_quit(false)
	# 自动加载存档
	if AUTOLOAD:GameControl.auto_load()
	
