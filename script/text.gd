extends VBoxContainer

func _enter_tree():
	set_process_input(false)
	return

func _input(event):
	if event is InputEventMouseButton:
		if not event.pressed:
			$TextPanel/RichTextLabel.percent_visible = 1
			_on_TextShowTimer_timeout()
	return


func set_name(name:String)->void:
	$NamePanel/Label.text = name
	return
func set_text(text:String)->void:
	$TextPanel/RichTextLabel.percent_visible = 0
	$TextPanel/RichTextLabel.text = text
	
	set_process_input(true)
	$"..".set_process_input(false)
	$TextPanel/RichTextLabel/TextShowTimer.start()
	return

func _on_TextShowTimer_timeout():
	if $TextPanel/RichTextLabel.text.length():
		if $TextPanel/RichTextLabel.percent_visible >= 1:
			# 显示完毕
			$TextPanel/RichTextLabel.percent_visible = 1
			$TextPanel/RichTextLabel/TextShowTimer.stop()
			$"..".set_process_input(true)
		else:
			# 未显示完
			$TextPanel/RichTextLabel.percent_visible +=  1.0 / $TextPanel/RichTextLabel.text.length()
	else:
		$TextPanel/RichTextLabel/TextShowTimer.stop()
