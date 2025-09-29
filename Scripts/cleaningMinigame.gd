extends Node2D

var running=false
var canCut=false
var cutting=false
var cutAmount=0
var removeStuff=true
var cutScene = preload("res://Scenes/cutting.tscn")
var currentLine

func _ready() -> void:
	pass

func _physics_process(_delta: float) -> void:
	if(running):
		if(not $"../../..".controller):
			$Sponge.global_position=get_global_mouse_position()
		else:
			if(Input.is_action_pressed("Right")):
				$Sponge.position.x+=1.5
			elif(Input.is_action_pressed("Left")):
				$Sponge.position.x-=1.5
			if(Input.is_action_pressed("Up")):
				$Sponge.position.y-=1.5
			elif(Input.is_action_pressed("Down")):
				$Sponge.position.y+=1.5
		if(Input.is_action_pressed("Place")):
			$Sponge.scale=Vector2(.5, .5)
			$"../Plate".remove_circle($"../Plate/PlateDirt".to_local(get_global_mouse_position()), 12)
			$"../Plate".remove_circle($"../Plate/PlateDirt".to_local(get_global_mouse_position()) + Vector2(0, 18), 12)
			$"../Plate".remove_circle($"../Plate/PlateDirt".to_local(get_global_mouse_position()) - Vector2(0, 18), 12)
		else:
			$Sponge.scale=Vector2(.6, .6)

	
func is_point_inside(point: Vector2) -> bool:
	var space_state = get_world_2d().direct_space_state
	
	var query = PhysicsPointQueryParameters2D.new()
	query.position = point
	query.collide_with_areas = true  # Detect areas
	query.collide_with_bodies = false  # Ignore bodies if you want
	
	var result = space_state.intersect_point(query)
	for item in result:
		if item.collider == $"../Area2D2":
			return true
	return false
