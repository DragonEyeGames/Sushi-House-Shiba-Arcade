extends CharacterBody2D
const SPEED = 150
func _process(delta: float) -> void:
	var yChange = 0
	var xChange = 0
	if(Input.is_action_pressed("Up")):
		yChange-=1
	if(Input.is_action_pressed("Down")):
		yChange=1
	if(Input.is_action_pressed("Left")):
		xChange-=1
	if(Input.is_action_pressed("Right")):
		xChange+=1
	if abs(xChange) == 1 and abs(yChange) == 1:
		xChange /= sqrt(2)
		yChange /= sqrt(2)
	xChange*=SPEED
	yChange*=SPEED
	velocity.x+=xChange
	velocity.y+=yChange
	move_and_slide()
	velocity=Vector2.ZERO
