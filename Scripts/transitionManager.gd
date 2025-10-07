extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimationPlayer.play("RESET")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
	
func transition_to(destination):
	$AnimationPlayer.play("leave")
	await get_tree().create_timer(1).timeout
	get_tree().change_scene_to_file(destination)
