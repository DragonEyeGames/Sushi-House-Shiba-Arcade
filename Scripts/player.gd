extends CharacterBody2D
const SPEED = 300
var canMove=true
var _dir = "down"
var walking=false

func _process(delta: float) -> void:
	var yChange = 0
	var xChange = 0
	if(Input.is_action_pressed("Up")):
		yChange-=1
	if(Input.is_action_pressed("Down")):
		yChange+=1
	if(Input.is_action_pressed("Left")):
		xChange-=1
	if(Input.is_action_pressed("Right")):
		xChange+=1
	if abs(xChange) == 1 and abs(yChange) == 1:
		xChange /= sqrt(2)
		yChange /= sqrt(2)
	xChange*=SPEED
	yChange*=SPEED
	if abs(xChange) > 0 or abs(yChange) > 0:
		walking = true
	else:
		walking=false
	if(yChange<0):
		_dir="up"
	elif(yChange>0):
		_dir="down"
	if(xChange<0):
		_dir="left"
	elif(xChange>0):
		_dir="right"
	velocity.x+=xChange
	velocity.y+=yChange
	if(canMove):
		move_and_slide()
		if(walking):
			if(_dir=="down" and $Sprite.animation!="walk"):
				$Sprite.play("walk")
			elif(_dir=="right" and $Sprite.animation!="right walk"):
				$Sprite.play("right walk")
			elif(_dir=="left" and $Sprite.animation!="left walk"):
				$Sprite.play("left walk")
			elif(_dir=="up" and $Sprite.animation!="back walk"):
				$Sprite.play("back walk")
		elif(not walking):
			if(_dir=="down" and $Sprite.animation!="idle"):
				$Sprite.play("idle")
			elif(_dir=="right" and $Sprite.animation!="idle right"):
				$Sprite.play("idle right")
			elif(_dir=="left" and $Sprite.animation!="idle left"):
				$Sprite.play("idle left")
			elif(_dir=="up" and $Sprite.animation!="back idle"):
				$Sprite.play("back idle")
	else:
		_dir="down"
		if($Sprite.animation!="idle"):
			$Sprite.play("idle")
	velocity=Vector2.ZERO
	if(position.y>50):
		z_index=15
	else:
		z_index=-1
