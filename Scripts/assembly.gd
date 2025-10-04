extends Draggable

var controllerButtonHovered=false

var assembly=[]

func _process(_delta: float) -> void:
	handleVisuals()
	if(dragging):
		drag()
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
	if(Input.is_action_just_pressed("Escape") and $"../../AssemblyLayer".visible):
		_on_button_pressed()
	# Check if the player's selected item is one we accept
	if(state=="placing" and "rice" in assembly and Input.is_action_just_pressed("Place")):
		if($Items/Items.fishEntered or $Items/Items2.fishEntered or $Items/Items3.fishEntered or $Items/Items4.fishEntered or $Items/Items.cucumberEntered or $Items/Items2.cucumberEntered or $Items/Items3.cucumberEntered or $Items/Items4.cucumberEntered):
			for child in $Items.get_children():
				if(child.fishEntered or child.cucumberEntered) :
					dragging=true
					draggedItem=child
					if(not controller.controller):
						dragOffset=draggedItem.global_position-get_global_mouse_position()
					else:
						dragOffset=draggedItem.global_position-$ControllerSelection.global_position
	elif(state=="placing" and not "rice" in assembly and Input.is_action_just_pressed("Place")):
		if($Items/Items.riceEntered or $Items/Items2.riceEntered or $Items/Items3.riceEntered or $Items/Items4.riceEntered):
			$"Display Items/Rice".visible=true
			assembly.append("rice")
			removeItem("cooked rice")
			for child in $Items.get_children():
				if(child.riceEntered):
					child.visible=false
			$Items/Items.visible=false
			$Items/Items2.visible=false
			$Items/Items3.visible=false
			$Items/Items4.visible=false
			var showList=[]
			for invItem in controller.playerInventory:
				if(invItem=="sliced fish" or invItem=="sliced cucumber"):
					showList.append(invItem)
			var showItem=-1
			for child in $Items.get_children():
				showItem+=1
				if len(showList)>=$Items.get_children().find(child)+1:
					child.visible=true
					for i in child.get_children():
						i.visible=false
					if child.get_node_or_null(showList[showItem]) !=null:
						child.get_node_or_null(showList[showItem]).visible=true
				else:
					child.visible=false
			await get_tree().create_timer(.5).timeout
			$"Button Holder".visible=true
			
	# Show prompts based on state
	if colliding:
		if controller.playerInventorySelect == "seaweed" and state=="":
			requirementsMet=true
		else:
			requirementsMet=false

func interact() -> void:
	if(state=="placing" or controller.playerInventorySelect!="seaweed"):
		return
	removeItem("seaweed")
	$ControllerSelection.visible=controller.controller
	var showList=[]
	for invItem in controller.playerInventory:
		if(invItem=="cooked rice"):
			showList.append(invItem)
	for i in len($Items.get_children()):
		if len(showList)>=i+1:
			$Items.get_child(i).visible=true
			$Items.get_child(i).global_position=$"../../Player".global_position
			var tween = create_tween()
			tween.tween_property($Items.get_child(i), "position", Vector2(-123, -99), .5) # move to (400, 300) in 0.5s
			for miniChild in $Items.get_child(i).get_children():
				miniChild.visible=false
			if $Items.get_child(i).get_node_or_null(showList[0]) !=null:
				$Items.get_child(i).get_node_or_null(showList[0]).visible=true
		else:
			$Items.get_child(i).visible=false
	$"../../Camera2D".following=self
	$"../../Camera2D".followingPlayer=false
	$"../../Camera2D".Zoom(5)
	$"Display Items/Seaweed".visible=true
	requirementsMet=false
	$"../../Player".canMove=false
	# Animate the alpha of the modulate color
	$"../../AssemblyLayer".visible=true
	for child in $"../../CanvasLayer".get_children():
		var t2 = create_tween()
		t2.tween_property(child, "modulate:a", 0.0, 1.0)
	var t = create_tween()
	t.tween_property($"../../AssemblyLayer/Button", "modulate:a", 1.0, 1.0)
	state="placing"


func _reset_visuals() -> void:
	for child in $"Display Items".get_children():
		child.visible=false
	state=""


func _on_button_pressed() -> void:
	$ControllerSelection.visible=false
	$"Button Holder/TextureButton".visible=true
	$"Button Holder/TextureButton2".visible=false
	$"Button Holder".visible=false
	$Items/Items.visible=false
	$Items/Items2.visible=false
	$Items/Items3.visible=false
	$Items/Items4.visible=false
	self.material.set_shader_parameter("outline_size", GameManager.outlineSize)
	if($"Display Items/Seaweed".visible):
		controller.playerInventory.append("seaweed")
		$"../../Player/PickingUp".play()
		$"Display Items/Seaweed".visible=false
	if($"Display Items/Rice".visible):
		controller.playerInventory.append("cooked rice")
		$"Display Items/Rice".visible=false
	if($"Display Items/SlicedFish".visible):
		controller.playerInventory.append("sliced fish")
		$"Display Items/SlicedFish".visible=false
	if($"Display Items/Onigiri".visible):
		controller.playerInventory.append("onigiri")
		$"../../Player/PickingUp".play()
		$"Display Items/Onigiri".visible=false
	if($"Display Items/Cucumber Onigiri".visible):
		controller.playerInventory.append("onigiri with cucumber")
		$"../../Player/PickingUp".play()
		$"Display Items/Cucumber Onigiri".visible=false
	if($"Display Items/Sushi".visible):
		controller.playerInventory.append("sushi")
		$"../../Player/PickingUp".play()
		$"Display Items/Sushi".visible=false
	if($"Display Items/Cucumber Sushi".visible):
		controller.playerInventory.append("sushi with cucumber")
		$"../../Player/PickingUp".play()
		$"Display Items/Cucumber Sushi".visible=false
	$"../../Camera2D".followingPlayer=true
	$"../../Camera2D".Zoom(1)
	$"../../CanvasLayer".visible=true
	$"../../Player".canMove=true
	#Animate the alpha of the modulate color
	for child in $"../../CanvasLayer".get_children():
		var t2 = create_tween()
		t2.tween_property(child, "modulate:a", 1.0, 1.0)
	var t = create_tween()
	t.tween_property($"../../AssemblyLayer/Button", "modulate:a", 0.0, 1.0)
	await get_tree().create_timer(1).timeout
	$"../../AssemblyLayer".visible=false
	$"../../CanvasLayer".visible=true
	_reset_visuals()
	assembly.clear()
	dragging=false
	draggedItem=null
	$ControllerSelection.position=Vector2(-60, -20)


func _on_texture_button_pressed() -> void:
	$"Display Items/Seaweed".visible=false
	$"Display Items/Rice".visible=false
	if("sliced fish" in assembly):
		if("sliced cucumber" in assembly):
			$"Display Items/Cucumber Sushi".visible=true
			removeItem("sliced fish")
			removeItem("sliced cucumber")
		else:
			$"Display Items/Sushi".visible=true
			removeItem("sliced fish")
	else:
		if("sliced cucumber" in assembly):
			removeItem("sliced cucumber")
			$"Display Items/Cucumber Onigiri".visible=true
		else:
			$"Display Items/Onigiri".visible=true
	$Items/Items.visible=false
	$Items/Items2.visible=false
	$Items/Items3.visible=false
	$Items/Items4.visible=false
	await get_tree().create_timer(.1).timeout
	$"Button Holder/TextureButton".visible=false
	$"Button Holder/TextureButton2".visible=true


func _on_pickup() -> void:
	_on_button_pressed()


func _on_fish_entered(_area: Area2D) -> void:
	assembly.append("sliced fish")


func _on_fish_exited(_area: Area2D) -> void:
	assembly.erase("sliced fish")


func _on_controller_collisions_area_entered(_area: Area2D) -> void:
	controllerButtonHovered=true


func _on_controller_collisions_area_exited(_area: Area2D) -> void:
	controllerButtonHovered=false


func _on_area_2d_2_area_exited(_area: Area2D) -> void:
	assembly.erase("sliced cucumber")


func _on_cucumber_entered(_area: Area2D) -> void:
	assembly.append("sliced cucumber")
