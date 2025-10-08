extends Station

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	item="plate"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	handleVisuals()
	if(colliding and controller.playerInventorySelect in item and state==""):
		requirementsMet=true
	else:
		requirementsMet=false
		
func interact():
	if(state=="placed"):
		return
	state="placed"
	removeItem("plate")
	$Plate.visible=true
	$"../../Player/SetDown".play()
	zoomIn()
	var plateIndex=0
	for item in controller.playerInventory:
		var stringList = []
		for child in $"Items".get_child(plateIndex).get_children():
			stringList.append(child.name)
		if(item in stringList):
			print("true")
			$Items.get_child(plateIndex).get_node(item).visible=true
			plateIndex+=1
		print(item)
