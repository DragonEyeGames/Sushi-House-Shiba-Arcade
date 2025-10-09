extends CanvasLayer

var canToggle=true
var settingsClosed=true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if(Input.is_action_just_pressed("Escape") and canToggle):
		if(not settingsClosed):
			return
		canToggle=false
		get_tree().paused = !get_tree().paused
		if(get_tree().paused):
			$Audio/Control/HSlider.value=GameManager.masterValue
			$Audio/Control/HSlider2.value=GameManager.sfxValue
			$Audio/Control/HSlider3.value=GameManager.musicValue
			$Initialize.play("open")
		else:
			$Initialize.play("close")
			saveGame()
		await get_tree().create_timer(.51).timeout
		canToggle=true


func _on_texture_button_2_pressed() -> void:
	settingsClosed=false
	$SettingsMenu/AnimationPlayer.play("showUp")
	



func _on_texture_button_pressed() -> void:
	settingsClosed=true
	$SettingsMenu/AnimationPlayer.play("hide")


func _on_resume() -> void:
	if(canToggle):
		if(not settingsClosed):
			return
		canToggle=false
		get_tree().paused = false
		$Initialize.play("close")
		saveGame()
		await get_tree().create_timer(.51).timeout
		canToggle=true
		
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


func _main() -> void:
	get_tree().paused = false
	saveGame()
	$"../ColorRect".transition_to("res://Scenes/startScene.tscn")


func _settings_hover() -> void:
	if(get_tree().paused):
		var tween: Tween = create_tween()
		tween.tween_property($Settings, "scale", Vector2(.5, .5), .25)


func _settings_exit() -> void:
	if(get_tree().paused):
		var tween: Tween = create_tween()
		tween.tween_property($Settings, "scale", Vector2(.43, .43), .25)


func _resume_hover() -> void:
	if(get_tree().paused):
		var tween: Tween = create_tween()
		tween.tween_property($Resume, "scale", Vector2(.5, .5), .25)


func _resume_exit() -> void:
	if(get_tree().paused):
		var tween: Tween = create_tween()
		tween.tween_property($Resume, "scale", Vector2(.43, .43), .25)


func _leave_hover() -> void:
	if(get_tree().paused):
		var tween: Tween = create_tween()
		tween.tween_property($Main, "scale", Vector2(.5, .5), .25)


func _leave_exit() -> void:
	if(get_tree().paused):
		var tween: Tween = create_tween()
		tween.tween_property($Main, "scale", Vector2(.43, .43), .25)


func _on_audio_mouse_entered() -> void:
	if(get_tree().paused):
		var tween: Tween = create_tween()
		tween.tween_property($SettingsMenu/Control/Audio, "scale", Vector2(.2, .2), .25)


func _on_audio_mouse_exited() -> void:
	if(get_tree().paused):
		var tween: Tween = create_tween()
		tween.tween_property($SettingsMenu/Control/Audio, "scale", Vector2(.18, .18), .25)


func _on_audio_pressed() -> void:
	$SettingsMenu/AnimationPlayer.play("hide")
	$Audio/AnimationPlayer.play("showUp")


func _on_audio_exit() -> void:
	$SettingsMenu/AnimationPlayer.play("showUp")
	$Audio/AnimationPlayer.play("hide")


func _on_rebind_x() -> void:
	$SettingsMenu/AnimationPlayer.play("showUp")
	$KeyRebind/AnimationPlayer.play("hide")


func _on_input_mouse_entered() -> void:
	if(get_tree().paused):
		var tween: Tween = create_tween()
		tween.tween_property($SettingsMenu/Control/Input, "scale", Vector2(.2, .2), .25)


func _on_input_mouse_exited() -> void:
	if(get_tree().paused):
		var tween: Tween = create_tween()
		tween.tween_property($SettingsMenu/Control/Input, "scale", Vector2(.18, .18), .25)


func _on_input_pressed() -> void:
	$SettingsMenu/AnimationPlayer.play("hide")
	$KeyRebind/AnimationPlayer.play("showUp")


func _x_pressed() -> void:
	settingsClosed=true
	$SettingsMenu/AnimationPlayer.play("hide")

func saveGame():
	var save = SaveData.new()
	save.masterVolume=GameManager.masterValue
	save.sfxVolume=GameManager.sfxValue
	save.musicVolume=GameManager.musicValue
	save.tutorial=GameManager.tutorial
	for action in InputMap.get_actions():
		save.input_map[action] = InputMap.action_get_events(action)
	save.writeSave()
