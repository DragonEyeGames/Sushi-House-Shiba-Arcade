extends Station

var placedItem
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	item=["dirty plate"]


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	handleVisuals()
	if($MinigameHolder.running==true and Input.is_action_just_pressed("Escape")):
		_on_button_pressed()
	if(colliding and controller.playerInventorySelect in item and state==""):
		requirementsMet=true
	elif(colliding and state=="placed" and placedItem in item):
		requirementsMet=true
	else:
		requirementsMet=false
	
func interact():
	if(not controller.interactiveItem==self):
		return
	var playerFade=create_tween()
	playerFade.tween_property($"../../Player", "modulate:a", 0.0, 1.0)
	if(controller.playerInventorySelect=="dirty plate" and ((state=="" and not $MinigameHolder.running))):
		placedItem="dirty plate"
		removeItem("dirty plate")
		state="placed"
		$Plate.newDirt()
		$MinigameHolder.cleaned=false
		$Plate.visible=true
		$"../../Camera2D".following=self
		$"../../Camera2D".followingPlayer=false
		$"../../Camera2D".Zoom(5)
		self.material.set_shader_parameter("outline_size", 0)
		$"../../Player".canMove=false
	# Animate the alpha of the modulate color
		for child in $"../../CanvasLayer".get_children():
			var t2 = create_tween()
			t2.tween_property(child, "modulate:a", 0.0, 1.0)
		var t = create_tween()
		t.tween_property($"../../CleaningLayer/Button", "modulate:a", 1.0, 1.0)
		await get_tree().create_timer(1.1).timeout
		$MinigameHolder.running=true


func _on_button_pressed() -> void:
	var playerFade=create_tween()
	playerFade.tween_property($"../../Player", "modulate:a", 1.0, 1.0)
	if(len(controller.playerInventory)<=4):
		$"../../Player/PickingUp".play()
		controller.playerInventory.append("plate")
		state=""
		placedItem=null
	self.material.set_shader_parameter("outline_size", 1.4)
	$MinigameHolder.running=false
	var t2 = create_tween()
	t2.tween_property($MinigameHolder/Sponge, "position", Vector2(50, -36), 1.0)
	$"../../Camera2D".followingPlayer=true
	$"../../Camera2D".Zoom(1)
	$"../../CanvasLayer".visible=true
	$"../../Player".canMove=true
	#Animate the alpha of the modulate color
	for child in $"../../CanvasLayer".get_children():
		var t3 = create_tween()
		t3.tween_property(child, "modulate:a", 1.0, 1.0)
	var t = create_tween()
	t.tween_property($"../../CleaningLayer/Button", "modulate:a", 0.0, 1.0)
	await get_tree().create_timer(1).timeout
	$"../../CanvasLayer".visible=true
