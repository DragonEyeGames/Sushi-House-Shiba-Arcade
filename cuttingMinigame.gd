extends Node2D

var running=false
var canCut=false
var cutting=false

func _process(delta: float) -> void:
	if(running):
		$Knife.global_position=get_global_mouse_position()
		if(Input.is_action_pressed("Place")):
			$Knife.scale=Vector2(.9, .9)
			cutting=true
		else:
			$Knife.scale=Vector2(1, 1)
			cutting=false


func _on_area_2d_area_entered(area: Area2D) -> void:
	canCut=true


func _on_area_2d_area_exited(area: Area2D) -> void:
	canCut=false
