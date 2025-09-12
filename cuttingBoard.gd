extends Sprite2D

var colliding=false

@export var item = ""

var placed=false
var placedItem
@export var controller: Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(not controller.interactiveItem==self):
		self.material.set_shader_parameter("outline_size", 0)
	if(colliding and item==controller.playerInventorySelect and placed==false):
		self.material.set_shader_parameter("outline_size", 1.4)
		controller.interactable="cutting board"
		controller.interactiveItem=self
	elif(colliding and placed and placedItem=="fish"):
		self.material.set_shader_parameter("outline_size", 1.4)
		controller.interactable="cutting board"
		controller.interactiveItem=self
	elif(colliding and placed and placedItem!="fish"):
		self.material.set_shader_parameter("outline_size", 1.4)
		controller.interactable="cutting board"
		controller.interactiveItem=self
	else:
		self.material.set_shader_parameter("outline_size", 0)


func _on_area_2d_area_entered(area: Area2D) -> void:
	colliding=true


func _on_area_2d_area_exited(area: Area2D) -> void:
	self.material.set_shader_parameter("outline_size", 0)
	if(controller.interactiveItem==self):
		controller.interactable=""
		controller.interactiveItem=null
	colliding=false
	
func interact():
	if(not controller.interactiveItem==self):
		return
	if(placed and not $MinigameHolder.running and $Fish.visible==true):
		$"../../Camera2D".following=self
		$"../../Camera2D".followingPlayer=false
		$"../../Camera2D".Zoom(5)
		self.material.set_shader_parameter("outline_size", 0)
		$"../../Player".canMove=false
	# Animate the alpha of the modulate color
		$"../../MinigameLayer".visible=true
		for child in $"../../CanvasLayer".get_children():
			var t = create_tween()
			t.tween_property(child, "modulate:a", 0.0, 1.0)
		var t = create_tween()
		t.tween_property($"../../MinigameLayer/Button", "modulate:a", 1.0, 1.0)
		await get_tree().create_timer(1.1).timeout
		$MinigameHolder.running=true
		return
	elif(placed and not $MinigameHolder.running and $Fish.visible==false):
		if(len(controller.playerInventory)<=4):
			$"../../Player/PickingUp".play()
			if($"Sliced Fish".visible):
				$"Sliced Fish".visible=false
				controller.playerInventory.append("sliced fish")
			else:
				$"Obliterated Fish".visible=false
				controller.playerInventory.append("obliterated fish")
			placed=false
			placedItem=null
			return
	elif(controller.playerInventorySelect=="fish"):
		placedItem=controller.playerInventorySelect
		controller.playerInventory.erase(controller.playerInventorySelect)
		controller.playerInventorySelect=""
		for i in $"../../CanvasLayer".get_children():
			var outline = i.get_node_or_null("Outline")
			if outline:
				outline.visible = false
		$Fish.visible=true
		placed=true


func _on_button_pressed() -> void:
	self.material.set_shader_parameter("outline_size", 1.4)
	$MinigameHolder.running=false
	var t2 = create_tween()
	t2.tween_property($MinigameHolder/Knife, "position", Vector2(50, -36), 1.0)
	$"../../Camera2D".followingPlayer=true
	$"../../Camera2D".Zoom(1)
	$"../../CanvasLayer".visible=true
	$"../../Player".canMove=true
	#Animate the alpha of the modulate color
	for child in $"../../CanvasLayer".get_children():
		var t = create_tween()
		t.tween_property(child, "modulate:a", 1.0, 1.0)
	var t = create_tween()
	t.tween_property($"../../MinigameLayer/Button", "modulate:a", 0.0, 1.0)
	await get_tree().create_timer(1).timeout
	$"../../MinigameLayer".visible=false
	$"../../CanvasLayer".visible=true
