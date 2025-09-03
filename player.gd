extends CharacterBody2D

func _process(delta: float) -> void:
	if(Input.is_action_just_pressed("Up")):
		position.y+=1
	if(Input.is_action_just_pressed("Down")):
		position.y-=1
	if(Input.is_action_just_pressed("Left")):
		position.x-=1
	if(Input.is_action_just_pressed("Right")):
		position.x+=1
