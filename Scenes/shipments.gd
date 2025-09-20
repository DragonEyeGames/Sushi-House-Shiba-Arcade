extends Node2D

var rising = false
var area1=false
var area2=false
var area3=false
var interacting=[]
var itemTypes = ["fish", "seaweed", "rice"]
@export var fish = 5
@export var seaweed = 5
@export var rice = 5
@export var cucumber = 5
var computerColliding=false
var inComputer=false
var doorOpen=false
var falling=false
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
			if(child.position.y<-220):
				rising=false
				doorOpen=true
	if(falling):
		for child in $Control.get_children():
			child.position.y+=120*delta
			if(child.position.y>216):
				falling=false
				doorOpen=false
	if(len(interacting)==1):
		if(interacting[0]=="1"):
			area1=true
			area2=false
			area3=false
		elif(interacting[0]=="2"):
			area1=false
			area2=true
			area3=false
		elif(interacting[0]=="3"):
			area1=false
			area2=false
			area3=true
	if(area1):
		$"Box".material.set_shader_parameter("outline_size", GameManager.outlineSize*2.3)
	else:
		$"Box".material.set_shader_parameter("outline_size", 0)
	if(area2):
		$"Box2".material.set_shader_parameter("outline_size", GameManager.outlineSize*2.3)
	else:
		$"Box2".material.set_shader_parameter("outline_size", 0)
	if(area3):
		$"Box3".material.set_shader_parameter("outline_size", GameManager.outlineSize*2.3)
	else:
		$"Box3".material.set_shader_parameter("outline_size", 0)
		
	if(Input.is_action_just_pressed("Place")):
		if(area1):
			$"Box".visible=false
			$"Box/Area2D/CollisionShape2D".disabled=true
			$"Box/StaticBody2D/CollisionShape2D".disabled=true
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
		elif(area3):
			$"Box3".visible=false
			$"Box3/StaticBody2D/CollisionShape2D".disabled=true
			$"Box3/Area2D/CollisionShape2D".disabled=true
			if(itemTypes[2]=="rice"):
				if(len($"..".playerInventory)<=4):
					$"..".playerInventory.append("rice box")
					$"../Player/PickingUp".play()
	if(not $Box.visible and not $Box2.visible and not $Box3.visible):
		GameManager.cargoClear=true
	
func shipment(inputFish, inputSeaweed, inputRice):
	fish=inputFish
	seaweed=inputSeaweed
	rice=inputRice
	$"../Camera2D".followingPlayer=true
	$"../Camera2D".Zoom(1)
	$"../CanvasLayer".visible=true
	$"../Player".canMove=true
	var tween = create_tween()
	tween.tween_property($"../Player", "modulate:a", 1.0, 1.0)
	$Computer/Computer.visible=false
	$"Computer/Zoom Target".visible=false
	for child in GameManager.canvasLayer.get_children():
			var tweenChild = create_tween()
			tweenChild.tween_property(child, "modulate:a", 1.0, 1.0)
	for scoreChild in GameManager.scoreLayer.get_children():
		var tweenChild = create_tween()
		tweenChild.tween_property(scoreChild, "modulate:a", 1.0, 1.0)
	GameManager.waitTime=randi_range(3, 5)
	await get_tree().create_timer(GameManager.waitTime).timeout
	if(fish==0):
		$Box.visible=false
		$"Box/Area2D/CollisionShape2D".disabled=true
		$"Box/StaticBody2D/CollisionShape2D".disabled=true
	else:
		$Box.visible=true
		$"Box/Area2D/CollisionShape2D".disabled=false
		$"Box/StaticBody2D/CollisionShape2D".disabled=false
	if(seaweed==0):
		$Box2.visible=false
		$"Box2/Area2D/CollisionShape2D".disabled=true
		$"Box2/StaticBody2D/CollisionShape2D".disabled=true
	else:
		$Box2.visible=true
		$"Box2/Area2D/CollisionShape2D".disabled=false
		$"Box2/StaticBody2D/CollisionShape2D".disabled=false
	if(rice==0):
		$Box3.visible=false
		$"Box3/Area2D/CollisionShape2D".disabled=true
		$"Box3/StaticBody2D/CollisionShape2D".disabled=true
	else:
		$Box3.visible=true
		$"Box3/Area2D/CollisionShape2D".disabled=false
		$"Box3/StaticBody2D/CollisionShape2D".disabled=false
	rising=true


func _1_entered(_area: Area2D) -> void:
	area1=true
	interacting.append("1")
	area2=false
	area3=false


func _1_exited(_area: Area2D) -> void:
	area1=false
	interacting.erase("1")


func _2_entered(_area: Area2D) -> void:
	area2=true
	area1=false
	area3=false
	interacting.append("2")


func _2_exited(_area: Area2D) -> void:
	area2=false
	interacting.erase("2")


func _on_area_2d_area_exited(area: Area2D) -> void:
	pass


func _on_area_2d_body_exited(body: Node2D) -> void:
	await get_tree().create_timer(2).timeout
	if(GameManager.cargoClear and doorOpen):
		falling=true


func _3_entered(_area: Area2D) -> void:
	area2=false
	area3=true
	area1=false
	interacting.append("3")


func _3_exited(_area: Area2D) -> void:
	area3=false
	interacting.erase("3")
