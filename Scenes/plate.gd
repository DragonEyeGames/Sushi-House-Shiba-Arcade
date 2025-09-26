extends Sprite2D

var cleaned=false
var openingFailure=false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	if(not cleaned):
		for child in get_children():
			child.visible=false
			cleaned=true
		$dirt.visible=true
	else:
		get_parent().queue_free()
