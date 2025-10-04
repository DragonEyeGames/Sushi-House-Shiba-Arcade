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
	$CanvasLayer/AnimationPlayer.play("showUp")


func _play_hovered() -> void:
	$Play/AnimationPlayer.play("grow")


func _on_texture_button_mouse_exited() -> void:
	$Play/AnimationPlayer.play("shrink")


func _on_texture_button_pressed() -> void:
	$ColorRect.transition_to("res://Scenes/main.tscn")


func _x() -> void:
	$CanvasLayer/AnimationPlayer.play("hide")


func _master_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), value/4)
	if(value==-80):
		AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), -80)


func _sfx(value: float) -> void:
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"), value/4)
	if(value==-80):
		AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"), -80)


func _music(value: float) -> void:
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), value/4)
	if(value==-80):
		AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), -80)
