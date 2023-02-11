extends Node

func translate(text:String)->String:
	var language:String = GameConfig.get_language()
	if language == GameConfig.get_available_languages()[0]: return text
	
	var translation_dict:Dictionary = FileManager.get_translation_sheet_dictionary()
	if text in translation_dict:
		return translation_dict[text][language]
	else:
		push_warning('翻译文本“%s”未找到，请检查翻译表文件！'%text)
		return text
