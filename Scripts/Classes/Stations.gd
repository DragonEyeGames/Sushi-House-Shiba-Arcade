extends Node2D

class_name Station

var colliding = false

@export var item = ""

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

func zoomIn():
	var playerFade=create_tween()
	playerFade.tween_property($"../../Player", "modulate:a", 0.0, 1.0)
	$"../../Camera2D".following=self
	$"../../Camera2D".followingPlayer=false
	$"../../Camera2D".Zoom(5)
	$"../../Player".canMove=false
	for child in $"../../Inventory".get_child(0).get_children():
		var t2 = create_tween()
		t2.tween_property(child, "modulate:a", 0.0, 1.0)
	for child in $"../../Score".get_children():
		var t2 = create_tween()
		t2.tween_property(child, "modulate:a", 0.0, 1.0)
		
func zoomOut():
	$"../../Camera2D".followingPlayer=true
	$"../../Camera2D".Zoom(1)
	$"../../Inventory".visible=true
	$"../../Score".visible=true
	$"../../Player".canMove=true
	#Animate the alpha of the modulate color
	for child in $"../../Inventory".get_child(0).get_children():
		var t3 = create_tween()
		t3.tween_property(child, "modulate:a", 1.0, 1.0)
	for child in $"../../Score".get_children():
		var t3 = create_tween()
		t3.tween_property(child, "modulate:a", 1.0, 1.0)

func removeItem(item_name: String) -> void:
	controller.placeCurrent(item_name)
