extends Resource

class_name SaveData

const SAVE_GAME_PATH := "user://savegame.tres"

@export var masterVolume := 0
@export var sfxVolume := 0
@export var musicVolume := 0

@export var input_map: Dictionary

@export var tutorial := true

func writeSave():
	ResourceSaver.save(self, SAVE_GAME_PATH)
	
static func loadSave():
	if ResourceLoader.exists(SAVE_GAME_PATH):
		return load(SAVE_GAME_PATH)
	return null
