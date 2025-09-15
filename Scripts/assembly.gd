extends Sprite2D

var colliding = false

@export var item = ["seaweed", "onigiri", "sushi", "cooked rice", "fish"]

var seaweedPlaced = false
var ricePlaced = false
var fishPlaced = false

var currentItem = ""
var itemMatching = false
var minigame=false

var dragging=false
var draggedItem
var dragOffset

var controllerButtonHovered=false

var assembly=[]

@export var controller: Node2D

func _ready() -> void:
	pass


func _process(delta: float) -> void:
	if(controllerButtonHovered and Input.is_action_just_pressed("Place") and $ControllerSelection.visible):
		if($"Button Holder/TextureButton".visible):
			_on_texture_button_pressed()
		if($"Button Holder/TextureButton2".visible):
			_on_button_pressed()
	if(controller.controller and $ControllerSelection.visible==true):
		if(Input.is_action_pressed("Right")):
			$ControllerSelection.position.x+=1.5
		if(Input.is_action_pressed("Left")):
			$ControllerSelection.position.x-=1.5
		if(Input.is_action_pressed("Up")):
			$ControllerSelection.position.y-=1.5
		if(Input.is_action_pressed("Down")):
			$ControllerSelection.position.y+=1.5
	elif(not controller.controller):
		$ControllerSelection.global_position=get_global_mouse_position()
	if(dragging):
		if(not controller.controller):
			draggedItem.global_position=get_global_mouse_position()+dragOffset
		else:
			draggedItem.global_position=$ControllerSelection.global_position+dragOffset
		if(not Input.is_action_pressed("Place")):
			dragging=false
	if(Input.is_action_just_pressed("Escape") and $"../../AssemblyLayer".visible):
		_on_button_pressed()
	# Check if the player's selected item is one we accept
	itemMatching = controller.playerInventorySelect in item
	if(minigame and ricePlaced and Input.is_action_just_pressed("Place") and not $SlicedFish.visible):
		if($Items.fishEntered or $Items2.fishEntered or $Items3.fishEntered or $Items4.fishEntered):
			if($Items.fishEntered):
				dragging=true
				draggedItem=$Items
				if(not controller.controller):
					dragOffset=draggedItem.global_position-get_global_mouse_position()
				else:
					dragOffset=draggedItem.global_position-$ControllerSelection.global_position
			elif($Items2.fishEntered):
				dragging=true
				draggedItem=$Items2
				if(not controller.controller):
					dragOffset=draggedItem.global_position-get_global_mouse_position()
				else:
					dragOffset=draggedItem.global_position-$ControllerSelection.global_position
			elif($Items3.fishEntered):
				dragging=true
				draggedItem=$Items3
				if(not controller.controller):
					dragOffset=draggedItem.global_position-get_global_mouse_position()
				else:
					dragOffset=draggedItem.global_position-$ControllerSelection.global_position
			elif($Items4.fishEntered):
				dragging=true
				draggedItem=$Items3
				if(not controller.controller):
					dragOffset=draggedItem.global_position-get_global_mouse_position()
				else:
					dragOffset=draggedItem.global_position-$ControllerSelection.global_position
	if(minigame and not ricePlaced and Input.is_action_just_pressed("Place")):
		if($Items.riceEntered or $Items2.riceEntered or $Items3.riceEntered or $Items4.riceEntered):
			$Rice.visible=true
			ricePlaced=true
			$"Button Holder".visible=true
			_consume_item("cooked rice")
			if($Items.riceEntered):
				$Items.visible=false
			elif($Items2.riceEntered):
				$Items2.visible=false
			elif($Items3.riceEntered):
				$Items3.visible=false
			elif($Items4.riceEntered):
				$Items4.visible=false
			var tween = create_tween()
			tween.tween_property($Items, "global_position", $"../../Player".global_position, .5)
			var tween2 = create_tween()
			tween2.tween_property($Items2, "global_position", $"../../Player".global_position, .5)
			var tween3 = create_tween()
			tween3.tween_property($Items3, "global_position", $"../../Player".global_position, .5)
			var tween4 = create_tween()
			tween4.tween_property($Items4, "global_position", $"../../Player".global_position, .5)
			await get_tree().create_timer(.5).timeout
			$Items.visible=false
			$Items2.visible=false
			$Items3.visible=false
			$Items4.visible=false
			var showList=[]
			for item in controller.playerInventory:
				if(item=="sliced fish"):
					showList.append(item)
			if len(showList)>=1:
				$Items.visible=true
				$Items.global_position=$"../../Player".global_position
				var tween5 = create_tween()
				tween5.tween_property($Items, "position", Vector2(-123, -99), .5) # move to (400, 300) in 0.5s
				for i in $Items.get_children():
					i.visible=false
				if $Items.get_node_or_null(showList[0]) !=null:
					$Items.get_node_or_null(showList[0]).visible=true
			else:
				$Items.visible=false
			if len(showList)>=2:
				$Items2.global_position=$"../../Player".global_position
				$Items2.visible=true
				var tween5 = create_tween()
				tween5.tween_property($Items2, "position", Vector2(99, -104), .5) # move to (400, 300) in 0.5s
				for i in $Items2.get_children():
					i.visible=false
				if $Items2.get_node_or_null(showList[1]) !=null:
					$Items2.get_node_or_null(showList[1]).visible=true
			else:
				$Items2.visible=false
			if len(showList)>=3:
				$Items3.global_position=$"../../Player".global_position
				$Items3.visible=true
				var tween5 = create_tween()
				tween5.tween_property($Items3, "position", Vector2(-126, -38), .5) # move to (400, 300) in 0.5s
				for i in $Items3.get_children():
					i.visible=false
				if $Items3.get_node_or_null(showList[2]) !=null:
					$Items3.get_node_or_null(showList[2]).visible=true
			else:
				$Items3.visible=false
			if len(showList)>=4:
				$Items4.global_position=$"../../Player".global_position
				$Items4.visible=true
				var tween5 = create_tween()
				tween5.tween_property($Items4, "position", Vector2(108, -42), .5) # move to (400, 300) in 0.5s
				for i in $Items4.get_children():
					i.visible=false
				if $Items4.get_node_or_null(showList[3]) !=null:
					$Items4.get_node_or_null(showList[3]).visible=true
			else:
				$Items4.visible=false
			
	# Show prompts based on state
	if colliding:
		if controller.playerInventorySelect == "seaweed" and not seaweedPlaced and currentItem == "":
			_show_prompt("Place Seaweed")
		elif controller.playerInventorySelect == "cooked rice" and seaweedPlaced and not ricePlaced and currentItem == "seaweed":
			_show_prompt("Place Cooked Rice")
		elif controller.playerInventorySelect == "sliced fish" and ricePlaced and not fishPlaced and currentItem == "onigiri":
			_show_prompt("Place Sliced Fish")
			if(len(controller.playerInventory) <= 4):
				_show_prompt("Pickup " + str(currentItem))
			else:
				self.material.set_shader_parameter("outline_size", 0)
		else:
			self.material.set_shader_parameter("outline_size", 0)
	else:
		self.material.set_shader_parameter("outline_size", 0)


func _show_prompt(text: String) -> void:
	self.material.set_shader_parameter("outline_size", 1.4)
	controller.interactable = "assembly board"
	controller.interactiveItem = self


func _on_area_2d_area_entered(area: Area2D) -> void:
	colliding = true


func _on_area_2d_area_exited(area: Area2D) -> void:
	self.material.set_shader_parameter("outline_size", 0)
	if(controller.interactiveItem==self):
		controller.interactable=""
		controller.interactiveItem=null
	colliding = false


func interact() -> void:
	if(minigame==true or controller.playerInventorySelect!="seaweed"):
		return
	_consume_item("seaweed")
	$ControllerSelection.visible=controller.controller
	var showList=[]
	for item in controller.playerInventory:
		if(item=="cooked rice"):
			showList.append(item)
	if len(showList)>=1:
		$Items.visible=true
		$Items.global_position=$"../../Player".global_position
		var tween = create_tween()
		tween.tween_property($Items, "position", Vector2(-123, -99), .5) # move to (400, 300) in 0.5s
		for i in $Items.get_children():
			i.visible=false
		if $Items.get_node_or_null(showList[0]) !=null:
			$Items.get_node_or_null(showList[0]).visible=true
	else:
		$Items.visible=false
	if len(showList)>=2:
		$Items2.global_position=$"../../Player".global_position
		$Items2.visible=true
		var tween = create_tween()
		tween.tween_property($Items2, "position", Vector2(99, -104), .5) # move to (400, 300) in 0.5s
		for i in $Items2.get_children():
			i.visible=false
		if $Items2.get_node_or_null(showList[1]) !=null:
			$Items2.get_node_or_null(showList[1]).visible=true
	else:
		$Items2.visible=false
	if len(showList)>=3:
		$Items3.global_position=$"../../Player".global_position
		$Items3.visible=true
		var tween = create_tween()
		tween.tween_property($Items3, "position", Vector2(-126, -38), .5) # move to (400, 300) in 0.5s
		for i in $Items3.get_children():
			i.visible=false
		if $Items3.get_node_or_null(showList[2]) !=null:
			$Items3.get_node_or_null(showList[2]).visible=true
	else:
		$Items3.visible=false
	if len(showList)>=4:
		$Items4.global_position=$"../../Player".global_position
		$Items4.visible=true
		var tween = create_tween()
		tween.tween_property($Items4, "position", Vector2(108, -42), .5) # move to (400, 300) in 0.5s
		for i in $Items4.get_children():
			i.visible=false
		if $Items4.get_node_or_null(showList[3]) !=null:
			$Items4.get_node_or_null(showList[3]).visible=true
	else:
		$Items4.visible=false
	$"../../Camera2D".following=self
	$"../../Camera2D".followingPlayer=false
	$"../../Camera2D".Zoom(5)
	$Seaweed.visible=true
	self.material.set_shader_parameter("outline_size", 0)
	$"../../Player".canMove=false
	# Animate the alpha of the modulate color
	$"../../AssemblyLayer".visible=true
	for child in $"../../CanvasLayer".get_children():
		var t = create_tween()
		t.tween_property(child, "modulate:a", 0.0, 1.0)
	var t = create_tween()
	t.tween_property($"../../AssemblyLayer/Button", "modulate:a", 1.0, 1.0)
	minigame=true


func _consume_item(item_name: String) -> void:
	controller.placeCurrent(item_name)


func _reset_visuals() -> void:
	$Seaweed.visible = false
	$Onigiri.visible = false
	$Sushi.visible = false
	seaweedPlaced = false
	ricePlaced = false
	fishPlaced = false


func _on_button_pressed() -> void:
	$ControllerSelection.visible=false
	$"Button Holder/TextureButton".visible=true
	$"Button Holder/TextureButton2".visible=false
	$"Button Holder".visible=false
	$Items.visible=false
	$Items2.visible=false
	$Items3.visible=false
	$Items4.visible=false
	self.material.set_shader_parameter("outline_size", 1.4)
	if($Seaweed.visible):
		controller.playerInventory.append("seaweed")
		$"../../Player/PickingUp".play()
		$Seaweed.visible=false
	if($Rice.visible):
		controller.playerInventory.append("cooked rice")
		$Rice.visible=false
	if($SlicedFish.visible):
		controller.playerInventory.append("sliced fish")
		$SlicedFish.visible=false
	if($Onigiri.visible):
		controller.playerInventory.append("onigiri")
		$"../../Player/PickingUp".play()
		$Onigiri.visible=false
	if($Sushi.visible):
		controller.playerInventory.append("sushi")
		$"../../Player/PickingUp".play()
		$Sushi.visible=false
	$"../../Camera2D".followingPlayer=true
	$"../../Camera2D".Zoom(1)
	$"../../CanvasLayer".visible=true
	$"../../Player".canMove=true
	#Animate the alpha of the modulate color
	for child in $"../../CanvasLayer".get_children():
		var t = create_tween()
		t.tween_property(child, "modulate:a", 1.0, 1.0)
	var t = create_tween()
	t.tween_property($"../../AssemblyLayer/Button", "modulate:a", 0.0, 1.0)
	await get_tree().create_timer(1).timeout
	$"../../AssemblyLayer".visible=false
	$"../../CanvasLayer".visible=true
	ricePlaced=false
	seaweedPlaced=false
	fishPlaced=false
	minigame=false
	assembly.clear()
	dragging=false
	draggedItem=null
	$ControllerSelection.position=Vector2(-61, -21)


func _on_texture_button_pressed() -> void:
	$Seaweed.visible=false
	$SlicedFish.visible=false
	$Rice.visible=false
	if("sliced fish" in assembly):
		$Sushi.visible=true
		_consume_item("sliced fish")
	else:
		$Onigiri.visible=true
	$Items.visible=false
	$Items2.visible=false
	$Items3.visible=false
	$Items4.visible=false
	await get_tree().create_timer(.1).timeout
	$"Button Holder/TextureButton".visible=false
	$"Button Holder/TextureButton2".visible=true


func _on_pickup() -> void:
	_on_button_pressed()


func _on_fish_entered(area: Area2D) -> void:
	assembly.append("sliced fish")


func _on_fish_exited(area: Area2D) -> void:
	assembly.erase("sliced fish")


func _on_controller_collisions_area_entered(area: Area2D) -> void:
	controllerButtonHovered=true


func _on_controller_collisions_area_exited(area: Area2D) -> void:
	controllerButtonHovered=false
