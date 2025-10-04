extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _hovered() -> void:
	$Settings/AnimationPlayer.play("grow")


func _hover_exited() -> void:
	$Settings/AnimationPlayer.play("shrink")


func _pressed() -> void:
	pass


func _play_hovered() -> void:
	$Play/AnimationPlayer.play("grow")


func _on_texture_button_mouse_exited() -> void:
	$Play/AnimationPlayer.play("shrink")


func _on_texture_button_pressed() -> void:
	pass # Replace with function body.
