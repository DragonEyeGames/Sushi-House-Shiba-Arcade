extends Node2D

var rising = false
var area1=false
var area2=false
var interacting=[]
var itemTypes = ["fish", "seaweed"]
@export var fish = 5
@export var seaweed = 5
@export var rice = 5
@export var cucumber = 5
var computerColliding=false
var inComputer=false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$Computer/Outline.visible=computerColliding
	if(computerColliding and Input.is_action_just_pressed("Place") and not ($"Computer/Zoom Target".visible or $Computer/Computer.visible)):
		$"Computer/Zoom Target".visible=true
		$"../Camera2D".following=$"Computer/Zoom Target"
		$"../Camera2D".followingPlayer=false
		$"../Camera2D".Zoom(14)
		$"../Player".canMove=false
		var tween = create_tween()
		tween.tween_property($"../Player", "modulate:a", 0.0, 1.0)
		var tween2 = create_tween()
		tween2.tween_property($"Computer/Zoom Target/ProgressBar", "value", 100.0, 3.0)
		inComputer=true
		for child in GameManager.canvasLayer.get_children():
			var tweenChild = create_tween()
			tweenChild.tween_property(child, "modulate:a", 0.0, 1.0)
		for scoreChild in GameManager.scoreLayer.get_children():
			var tweenChild = create_tween()
			tweenChild.tween_property(scoreChild, "modulate:a", 0.0, 1.0)
		await get_tree().create_timer(3.1).timeout
		$"Computer/Zoom Target".visible=false
		await get_tree().create_timer(.2).timeout
		$Computer/Computer.visible=true
	if(inComputer):
		$Computer/Outline.visible=false
	if(rising):
		for child in $Control.get_children():
			child.position.y-=120*delta
	if(len(interacting)==1):
		if(interacting[0]=="1"):
			area1=true
			area2=false
		elif(interacting[0]=="2"):
			area1=false
			area2=true
	if(area1):
		$"Box".material.set_shader_parameter("outline_size", GameManager.outlineSize)
	else:
		$"Box".material.set_shader_parameter("outline_size", 0)
	if(area2):
		$"Box2".material.set_shader_parameter("outline_size", GameManager.outlineSize)
	else:
		$"Box2".material.set_shader_parameter("outline_size", 0)
		
	if(Input.is_action_just_pressed("Place")):
		if(area1):
			$"Box".visible=false
			$"Box/Area2D/CollisionShape2D".disabled=true
			$"Box/StaticBody2D/CollisionShape2D".disabled=false
			if(itemTypes[0]=="fish"):
				if(len($"..".playerInventory)<=4):
					$"..".playerInventory.append("fish box")
					$"../Player/PickingUp".play()
		elif(area2):
			$"Box2".visible=false
			$"Box2/StaticBody2D/CollisionShape2D".disabled=true
			$"Box2/Area2D/CollisionShape2D".disabled=true
			if(itemTypes[1]=="seaweed"):
				if(len($"..".playerInventory)<=4):
					$"..".playerInventory.append("seaweed box")
					$"../Player/PickingUp".play()
	
func shipment(inputFish, inputSeaweed):
	fish=inputFish
	seaweed=inputSeaweed
	$"../Camera2D".followingPlayer=true
	$"../Camera2D".Zoom(1)
	$"../CanvasLayer".visible=true
	$"../Player".canMove=true
	var tween = create_tween()
	tween.tween_property($"../Player", "modulate:a", 1.0, 1.0)
	$Computer/Computer.visible=false
	$"Computer/Zoom Target".visible=false
	await get_tree().create_timer(40).timeout
	if(fish==0):
		$Box.visible=false
	if(seaweed==0):
		$Box2.visible=false
	rising=true


func _1_entered(_area: Area2D) -> void:
	area1=true
	interacting.append("1")
	area2=false


func _1_exited(_area: Area2D) -> void:
	area1=false
	interacting.erase("1")


func _2_entered(_area: Area2D) -> void:
	area2=true
	area1=false
	interacting.append("2")


func _2_exited(_area: Area2D) -> void:
	area2=false
	interacting.erase("2")
