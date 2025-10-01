extends Node2D

var colliding=false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if(len($Plates.get_children())>0):
		if(colliding and len($"../..".playerInventory)<=4 and $"../..".playerInventorySelect!="plate"):
			for child in $Plates.get_children():
				child.material.set_shader_parameter("outline_size", 0.0)
			$Plates.get_child(-1).material.set_shader_parameter("outline_size", GameManager.outlineSize)
			if(Input.is_action_just_pressed("Place")):
				$Plates.get_child(-1).queue_free()
				$"../..".playerInventory.append("plate")
		elif(colliding and $"../..".playerInventorySelect=="plate" and Input.is_action_just_pressed("Place")):
			placePlate()
		else:
			$Plates.get_child(-1).material.set_shader_parameter("outline_size", 0.0)
	elif(colliding and $"../..".playerInventorySelect=="plate" and Input.is_action_just_pressed("Place")):
		print("PPPPLLLLLLLLAAAAAAACCCCCCCEEEEEEE")
		placePlate()
	else:
		print("NOTHING")


func _on_area_2d_area_entered(_area: Area2D) -> void:
	colliding=true


func _on_area_2d_area_exited(_area: Area2D) -> void:
	colliding=false
	
func placePlate():
	$"../..".placeCurrent("plate")
	var plate=$Plate.duplicate()
	plate.material=plate.material.duplicate()
	if(len($Plates.get_children())>0):
		plate.position=$Plates.get_child(-1).position
		plate.position.y-=4
		plate.z_index=$Plates.get_child(-1).z_index+1
	else:
		plate.z_index=0
		plate.position=Vector2(0, -64)
	$Plates.add_child(plate)
	plate.visible=true
