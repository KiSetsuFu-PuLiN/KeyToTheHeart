extends Scene

# warning-ignore:unused_argument
func _process(delta):
	$touch_to_start.modulate.a = sin(Time.get_ticks_msec()/1000.0)/2+0.5
	return

func _on_touch_to_start_pressed():
	change_scene("blank")
	set_process(false)
	return

