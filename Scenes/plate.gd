extends Sprite2D

var cleaned=false
var openingFailure=false
var rolling=false


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	if(not cleaned and rolling):
		for child in get_children():
			child.visible=false
		cleaned=true
		$dirt.visible=true
