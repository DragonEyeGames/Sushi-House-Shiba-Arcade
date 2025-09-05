extends Node2D

var running=false
var canCut=false
var cutting=false
var cutAmount=0
var cutScene = preload("res://cutting.tscn")
var currentLine

func _ready() -> void:
	currentLine=$Lines/Line2D

func _physics_process(delta: float) -> void:
	if(not running):
		cutting=false
		canCut=false
		for child in $Lines.get_children():
			child.queue_free()
		cutAmount=0
	if(running):
		$Knife.global_position=get_global_mouse_position()
		if(Input.is_action_pressed("Place")):
			$Knife.scale=Vector2(.9, .9)
			if(cutting==false):
				var line := Line2D.new()               # Make a new Line2D
				line.width = 0.635                        # Set line thickness
				line.default_color = Color.BLACK       # Set color
				line.z_index = 1    
				currentLine=line                 # Make sure it's on top
				$Lines.add_child(line)  
				line.global_position=$Knife/Area2D.global_position
				currentLine.add_point(currentLine.to_local($Knife/Area2D/CollisionShape2D.global_position))
			cutting=true
		else:
			$Knife.scale=Vector2(1, 1)
			cutting=false
	if(cutting and canCut):
		if(is_point_inside($Knife/Area2D/CollisionShape2D.global_position)):
			currentLine.add_point(currentLine.to_local($Knife/Area2D/CollisionShape2D.global_position))
			if currentLine.points.size() >= 2:
				var last_point = currentLine.points[-2]
				var new_point = currentLine.points[-1]
				cutAmount += last_point.distance_to(new_point)
				if(cutAmount<80):
					$"../Fish".visible=true
				elif(cutAmount<=140):
					if($"../Fish".visible):
						for child in $Lines.get_children():
							child.queue_free()
						var line := Line2D.new()               # Make a new Line2D
						line.width = 0.635                        # Set line thickness
						line.default_color = Color.BLACK       # Set color
						line.z_index = 1    
						currentLine=line                 # Make sure it's on top
						$Lines.add_child(line)  
						line.global_position=$Knife/Area2D.global_position
						currentLine.add_point(currentLine.to_local($Knife/Area2D/CollisionShape2D.global_position))
					$"../Fish".visible=false
					$"../Sliced Fish".visible=true
				else:
					if($"../Sliced Fish".visible):
						for child in $Lines.get_children():
							child.queue_free()
						var line := Line2D.new()               # Make a new Line2D
						line.width = 0.635                        # Set line thickness
						line.default_color = Color.BLACK       # Set color
						line.z_index = 1    
						currentLine=line                 # Make sure it's on top
						$Lines.add_child(line)  
						line.global_position=$Knife/Area2D.global_position
						currentLine.add_point(currentLine.to_local($Knife/Area2D/CollisionShape2D.global_position))
					$"../Sliced Fish".visible=false
					$"../Obliterated Fish".visible=true


func _on_area_2d_area_entered(area: Area2D) -> void:
	pass


func _on_area_2d_area_shape_entered(area_rid, area: Area2D, area_shape_index: int, local_shape_index: int) -> void:
	var line := Line2D.new()               # Make a new Line2D
	line.width = 0.635                        # Set line thickness
	line.default_color = Color.BLACK       # Set color
	line.z_index = 1    
	currentLine=line                 # Make sure it's on top
	$Lines.add_child(line)  
	line.global_position=$Knife/Area2D.global_position
	currentLine.add_point(currentLine.to_local($Knife/Area2D/CollisionShape2D.global_position))
	canCut=true

func _on_area_2d_area_shape_exited(area_rid, area: Area2D, area_shape_index: int, local_shape_index: int) -> void:
	canCut = false
	
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
