extends Node2D

class_name Station

var colliding = false

@export var item = ""

@export var minigame=false

@export var controller: Node2D

var state=""

var requirementsMet=false

func handleVisuals() :
	if(requirementsMet and controller.interactiveItem==self):
		self.material.set_shader_parameter("outline_size", GameManager.outlineSize)
		if(Input.is_action_just_pressed("Place")):
			interact()
	else:
		self.material.set_shader_parameter("outline_size", 0)

func _on_area_2d_area_entered(_area: Area2D) -> void:
	colliding = true
	controller.interactiveItem=self


func _on_area_2d_area_exited(_area: Area2D) -> void:
	self.material.set_shader_parameter("outline_size", 0)
	if(controller.interactiveItem==self):
		controller.interactable=""
		controller.interactiveItem=null
	colliding = false


func interact() -> void:
	pass


func removeItem(item_name: String) -> void:
	controller.placeCurrent(item_name)
