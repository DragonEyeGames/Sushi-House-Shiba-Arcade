extends Draggable

var itemList=[]
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	item="plate"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	handleVisuals()
	if(colliding and controller.playerInventorySelect in item and state==""):
		requirementsMet=true
	else:
		requirementsMet=false
	if(state=="placed"):
		for displayItem in $Items.get_children():
			if(displayItem.mouseEntered):
				if(Input.is_action_just_pressed("Place")):
					dragging=true
					draggedItem=displayItem
					dragOffset=draggedItem.global_position-get_global_mouse_position()
	drag()
	var onPlate=[]
	for displayItem in itemList:
		for visual in displayItem.get_children():
			if(visual.visible and visual.name!="Area2D"):
				onPlate.append(visual.name)
	onPlate = onPlate.map(func(x): return str(x))
	if(len(itemList)>=1 and not (len(itemList)>=2 and ("onigiri" in onPlate or "sushi" in onPlate or "onigiri with cucumber" in onPlate or "sushi with cucumber" in onPlate))):
		$TextureButton.visible=true
	else:
		$TextureButton.visible=false
					
		
func interact():
	if(state=="placed"):
		return
	state="placed"
	removeItem("plate")
	$Plate.visible=true
	$"../../Player/SetDown".play()
	zoomIn()
	var plateIndex=0
	for newItem in controller.playerInventory:
		var stringList = []
		for child in $"Items".get_child(plateIndex).get_children():
			stringList.append(child.name)
		if(newItem in stringList):
			$Items.get_child(plateIndex).get_node(newItem).visible=true
			plateIndex+=1


func _plate_entered(area: Area2D) -> void:
	itemList.append(area.get_parent())


func _plate_exited(area: Area2D) -> void:
	itemList.erase(area.get_parent())


func _assemble_hover() -> void:
	var tween = create_tween()
	tween.tween_property($TextureButton, "scale", Vector2(1.1, 1.1), .15)
	
func _assemble_exit() -> void:
	var tween = create_tween()
	tween.tween_property($TextureButton, "scale", Vector2(1, 1), .15)


func _on_assemble() -> void:
	var onPlate=[]
	for displayItem in itemList:
		for visual in displayItem.get_children():
			if(visual.visible and visual.name!="Area2D"):
				onPlate.append(visual.name)
	onPlate = onPlate.map(func(x): return str(x))
	print(onPlate)
	onPlate.sort()
	print(onPlate)
	if(len(onPlate)==1):
		controller.playerInventory.append(onPlate[0] + " meal")
	elif(len(onPlate)==2):
		controller.playerInventory.append(onPlate[0] + " with " + onPlate[1] + " meal")
	elif(len(onPlate)==3):
		controller.playerInventory.append(onPlate[0] + " with " + onPlate[1] + " with " + onPlate[2] + " meal")
	elif(len(onPlate)==4):
		controller.playerInventory.append(onPlate[0] + " with " + onPlate[1] + " with " + onPlate[2] + " with " + onPlate[3] + " meal")
	print(controller.playerInventory)
	itemList.clear()
	for container in $Items.get_children():
		for sprite in container.get_children():
			if(sprite.name!="Area2D"):
				sprite.visible=false
	zoomOut()
	$Plate.visible=false
