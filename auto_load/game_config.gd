# 本节点用于辅助进行游戏设置的存取
# 主要设置项请看主场景根节点Main

extends Node

func get_available_languages()->Array:
	var translation_sheet_dictionary:Dictionary = FileManager.get_translation_sheet_dictionary()
	var sample:Dictionary = translation_sheet_dictionary.values()[0]
	var ret:Array = sample.keys()
	return ret

func set_language(language:String)->void:
	$"/root/Main".language = language
	return
func get_language()->String:
	return $"/root/Main".language
