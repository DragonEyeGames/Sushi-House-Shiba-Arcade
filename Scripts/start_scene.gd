extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var save = SaveData.loadSave()
	if(save != null):
		GameManager.musicValue=save.musicVolume
		GameManager.masterValue=save.masterVolume
		GameManager.sfxValue=save.sfxVolume
		GameManager.tutorial=save.tutorial
		for action in save.input_map:
			InputMap.action_erase_events(action)
			for input_event in save.input_map[action]:
				InputMap.action_add_event(action, input_event)
	$Audio/Control/HSlider.value=GameManager.masterValue
	$Audio/Control/HSlider2.value=GameManager.sfxValue
	$Audio/Control/HSlider3.value=GameManager.musicValue


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
	$SettingsMenu/AnimationPlayer.play("showUp")


func _play_hovered() -> void:
	var tween: Tween = create_tween()
	tween.tween_property($Play, "scale", Vector2(.5, .5), .25)


func _on_texture_button_mouse_exited() -> void:
	var tween: Tween = create_tween()
	tween.tween_property($Play, "scale", Vector2(.43, .43), .25)


func _start_game() -> void:
	$ColorRect.transition_to("res://Scenes/main.tscn")
	GameManager.masterValue=$Audio/Control/HSlider.value
	GameManager.sfxValue=$Audio/Control/HSlider2.value
	GameManager.musicValue=$Audio/Control/HSlider3.value
	var save = SaveData.new()
	save.masterVolume=GameManager.masterValue
	save.sfxVolume=GameManager.sfxValue
	save.musicVolume=GameManager.musicValue
	save.tutorial=GameManager.tutorial
	for action in InputMap.get_actions():
		save.input_map[action] = InputMap.action_get_events(action)
	save.writeSave()


func _x() -> void:
	$SettingsMenu/AnimationPlayer.play("hide")


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


func _on_audio_pressed() -> void:
	$SettingsMenu/AnimationPlayer.play("hide")
	$Audio/AnimationPlayer.play("showUp")


func _on_audio_mouse_entered() -> void:
	var tween: Tween = create_tween()
	tween.tween_property($SettingsMenu/Control/Audio, "scale", Vector2(.2, .2), .25)


func _on_audio_mouse_exited() -> void:
	var tween: Tween = create_tween()
	tween.tween_property($SettingsMenu/Control/Audio, "scale", Vector2(.18, .18), .25)


func _audio_x_pressed() -> void:
	$SettingsMenu/AnimationPlayer.play("showUp")
	$Audio/AnimationPlayer.play("hide")


func _on_input_mouse_entered() -> void:
	var tween: Tween = create_tween()
	tween.tween_property($SettingsMenu/Control/Input, "scale", Vector2(.2, .2), .25)


func _on_input_mouse_exited() -> void:
	var tween: Tween = create_tween()
	tween.tween_property($SettingsMenu/Control/Input, "scale", Vector2(.18, .18), .25)


func _on_settings_input_pressed() -> void:
	$SettingsMenu/AnimationPlayer.play("hide")
	$KeyRebind/AnimationPlayer.play("showUp")


func _input_remap_x_() -> void:
	$SettingsMenu/AnimationPlayer.play("showUp")
	$KeyRebind/AnimationPlayer.play("hide")


func _on_option_button_item_selected(index: int) -> void:
	if(index==0):
		GameManager.minigameControls="mouse"
	if(index==1):
		GameManager.minigameControls="arrows"
	if(index==2):
		GameManager.minigameControls="wasd"
