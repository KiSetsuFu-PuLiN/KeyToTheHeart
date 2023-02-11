extends Scene

func init()->void:
	start_event("rooftop/_init")
	$"..".eli_wakeup_from_rooftop = true
	return
