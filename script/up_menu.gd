extends Control

export var is_up:bool = true
export var up_down_duration:float = 0.7
func _on_DownButton_pressed():
	if is_up:
		$DownButton/Tween.interpolate_property(self, "rect_position",
				self.rect_position, Vector2(0,$BackGround.rect_size.y), up_down_duration,
				Tween.TRANS_SINE, Tween.EASE_IN_OUT)
		$DownButton/Tween.start()
		$DownButton.flip_v = true
		is_up = false
	else:
		$DownButton/Tween.interpolate_property(self, "rect_position",
				self.rect_position, Vector2(0,0), up_down_duration,
				Tween.TRANS_SINE, Tween.EASE_IN_OUT)
		$DownButton/Tween.start()
		$DownButton.flip_v = false
		is_up = true
	return


var item_detail:Dictionary = {
		"白兔玩偶":"再熟悉不过的玩偶。被系上了红色丝带，如同礼物一般精致。",
		"咖啡豆":"一些咖啡豆，可以用于榨取咖啡。",
		"水晶球":"一颗沉甸甸而晶莹剔透的水晶球",
		"八音盒":"即使并没有转动，也能隐约听见它的记忆"
}
export var current_item_index:int = -1
func _on_ItemList_item_selected(index):
	if index == current_item_index:
		$ItemDetail/Icon.texture = $ItemList.get_item_icon(index)
		$ItemDetail/Detail.text = item_detail[$ItemList.get_item_text(index)]
		$ItemDetail.visible = true
	else:
		current_item_index = index
	return
func _on_ItemDetail_pressed():
	$ItemDetail.visible = false
	return
