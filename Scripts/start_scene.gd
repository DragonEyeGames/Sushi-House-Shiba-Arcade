extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var save = SaveData.loadSave()
	if(save != null):
		GameManager.musicValue=save.musicVolume
		GameManager.masterValue=save.masterVolume
		GameManager.sfxValue=save.sfxVolume
	$CanvasLayer/Control/HSlider.value=GameManager.masterValue
	$CanvasLayer/Control/HSlider2.value=GameManager.sfxValue
	$CanvasLayer/Control/HSlider3.value=GameManager.musicValue


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _hovered() -> void:
	var tween: Tween = create_tween()
	tween.tween_property($Settings, "scale", Vector2(.5, .5), .25)


func _hover_exited() -> void:
	var tween: Tween = create_tween()
	tween.tween_property($Settings, "scale", Vector2(.43, .43), .25)


func _pressed() -> void:
	$CanvasLayer/AnimationPlayer.play("showUp")


func _play_hovered() -> void:
	var tween: Tween = create_tween()
	tween.tween_property($Play, "scale", Vector2(.5, .5), .25)


func _on_texture_button_mouse_exited() -> void:
	var tween: Tween = create_tween()
	tween.tween_property($Play, "scale", Vector2(.43, .43), .25)


func _on_texture_button_pressed() -> void:
	GameManager.masterValue=$CanvasLayer/Control/HSlider.value
	GameManager.sfxValue=$CanvasLayer/Control/HSlider2.value
	GameManager.musicValue=$CanvasLayer/Control/HSlider3.value
	var save = SaveData.new()
	save.masterVolume=GameManager.masterValue
	save.sfxVolume=GameManager.sfxValue
	save.musicVolume=GameManager.musicValue
	save.writeSave()
	$ColorRect.transition_to("res://Scenes/main.tscn")


func _x() -> void:
	$CanvasLayer/AnimationPlayer.play("hide")


func _master_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), value/4)
	if(value==-80):
		AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), -80)
	GameManager.masterValue=value


func _sfx(value: float) -> void:
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"), value/4)
	if(value==-80):
		AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"), -80)
	GameManager.sfxValue=value


func _music(value: float) -> void:
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), value/4)
	if(value==-80):
		AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), -80)
	GameManager.musicValue=value
