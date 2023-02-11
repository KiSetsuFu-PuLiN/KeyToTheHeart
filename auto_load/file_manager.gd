# 本节点提供文件存取相关函数
# 存取csv文件
# 存取存档文件

extends Node

var translation_sheet_dictionary:Dictionary = {}
func get_translation_sheet_dictionary() -> Dictionary:
	if translation_sheet_dictionary.empty():
		translation_sheet_dictionary = parse_csv_file_with_key("res://resource/csv_sheet/translation_sheet.csv","简体中文")
	return translation_sheet_dictionary

func get_dialog_event(event_name:String) -> Array:
	var path:String = "res://resource/csv_sheet/dialog_event_sheet/"
	var check_items = ['人物','立绘','文本',"CG","SE"]
	
	path += event_name
	path += '.csv'
	var ret:Array = parse_csv_file(path)
	assert(ret,"表格读取失败")
	if ret[0].keys()!=check_items:
		push_warning("表头不合规范，应为%s,实为%s"%[check_items,ret[0].keys()])
	return ret

func parse_csv_file(path:String) -> Array:
	# path: csv文件的路径
	# 注意：godot仅支持 UTF-8 编码格式，用wps编辑完表格之后，需要用记事本重新“另存为”编码
	
	var file:File = File.new()
	assert(not file.open(path, File.READ), "表格文件打开失败")
	# 读取第一行
	var csv_title = file.get_csv_line()
	
	# 表格至少两列
	assert(csv_title.size()>1,"表格至少两列")
	
	# 字符串池数组 转 数组
	var keys:Array = []
	for key in csv_title:
		keys.push_back(key)
	
	var data_list:Array = []
	var err_count:int = 0
	# 逐行读取
	var csv_line = file.get_csv_line()
	while csv_line.size() > 1:
		
		# 数据不对齐时，跳过并计数错误
		if csv_line.size() != csv_title.size():
			err_count += 1
			print_debug("数据有误，与第一行数据大小不一致")
			print(csv_title)
			print(csv_line)
			csv_line = file.get_csv_line()
			continue
		
		var data:Dictionary = {}
		for i in range(csv_title.size()):
			data[csv_title[i]] = csv_line[i]
		data_list.append(data)
		
		csv_line = file.get_csv_line()
	if err_count>0:
		print_debug("读取文件发生错误数量：%d"%err_count)
	
	file.close()
	return data_list

func parse_csv_file_with_key(path:String, key:String) -> Dictionary:
	# path: csv文件的路径
	# key: 读取csv后，用来检索具体行的主键字符串
	# 注意：godot仅支持 UTF-8 编码格式，用wps编辑完表格之后，需要用记事本重新“另存为”编码
	
	var file:File = File.new()
	assert(not file.open(path, File.READ), "表格文件打开失败")
	
	# 读取第一行
	var csv_title = file.get_csv_line()
	
	# 表格至少两列
	assert(csv_title.size()>1,"表格至少两列，或不为UTF-8格式")
	
	# 字符串池数组 转 数组
	var keys:Array = []
	for key in csv_title:
		keys.push_back(key)
		
	# 主键字符串应该在表头中
	assert(key in csv_title,"主键选取错误，主键不在表头中")
	
	var data_list:Dictionary = {}
	var err_count:int = 0
	
	# 逐行读取
	var csv_line = file.get_csv_line()
	while csv_line.size() > 1:
		
		# 数据不对齐时，跳过并计数错误
		if csv_line.size() != csv_title.size():
			err_count += 1
			print_debug("数据有误，与第一行数据大小不一致")
			print(csv_title)
			print(csv_line)
			csv_line = file.get_csv_line()
			continue
		
		var data:Dictionary = {}
		for i in range(csv_title.size()):
			data[csv_title[i]] = csv_line[i]
		data_list[data[key]] = data
		
		csv_line = file.get_csv_line()
	
	if err_count>0:
		print_debug("读取文件发生错误数量：%d"%err_count)
	
	file.close()
	return data_list
	
