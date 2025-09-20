extends Node2D

var playerColliding=false
var inComputer=false
var fish = 0
var seaweed=0
var rice = 0
var countingDown=0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Computer.visible=false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(GameManager.cargoClear and $Waiting.visible):
		$Waiting.visible=false
		inComputer=false
	if(countingDown>0):
		countingDown-=delta
		$Ordered/RichTextLabel3.text=str(int(round(countingDown)))
		if(countingDown<=0):
			$Ordered/RichTextLabel3.text="Arrived"
			countingDown=0
			await get_tree().create_timer(4).timeout
			$Ordered.visible=false
			$Waiting.visible=true
	if(fish==0 and seaweed==0):
		$Computer/Order.visible=false
	else:
		$Computer/Order.visible=true
	$Outline.visible=playerColliding
	if(inComputer):
		$Outline.visible=false
		$Computer/Fish/Count.text=str(fish)
		$Computer/Seaweed/Count.text=str(seaweed)
		$Computer/Rice/Count.text=str(rice)
	if(Input.is_action_just_pressed("Place") and playerColliding and not inComputer):
		$"Zoom Target".visible=true
		GameManager.camera.following=$"Zoom Target"
		GameManager.camera.followingPlayer=false
		GameManager.camera.Zoom(14)
		GameManager.player.canMove=false
		for child in GameManager.canvasLayer.get_children():
			var tweenChild = create_tween()
			tweenChild.tween_property(child, "modulate:a", 0.0, 1.0)
		for scoreChild in GameManager.scoreLayer.get_children():
			var tweenChild = create_tween()
			tweenChild.tween_property(scoreChild, "modulate:a", 0.0, 1.0)
		var tween = create_tween()
		tween.tween_property(GameManager.player, "modulate:a", 0.0, 1.0)
		var tween2 = create_tween()
		tween2.tween_property($"Zoom Target/ProgressBar", "value", 100.0, 3.0)
		inComputer=true
		await get_tree().create_timer(3.1).timeout
		$"Zoom Target".visible=false
		await get_tree().create_timer(.2).timeout
		$Computer.visible=true


func _on_area_2d_area_entered(_area: Area2D) -> void:
	playerColliding=true


func _on_area_2d_area_exited(_area: Area2D) -> void:
	playerColliding=false


func _on_order_pressed() -> void:
	get_parent().shipment(fish, seaweed, rice)
	$Ordered.visible=true
	$"Zoom Target/ProgressBar".value=0
	countingDown=GameManager.waitTime
	


func _on_fish_p_pressed() -> void:
	if(not fish<0):
		fish-=1


func on_fish_n_pressed() -> void:
	if(fish<99):
		fish+=1


func _seaweed_n() -> void:
	if(not seaweed<0):
		seaweed-=1


func _seaweed_p() -> void:
	if(seaweed<99):
		seaweed+=1


func _rice_n_pressed() -> void:
	if(not rice<0):
		rice-=1


func _rice_p_pressed() -> void:
	if(rice<99):
		rice+=1
