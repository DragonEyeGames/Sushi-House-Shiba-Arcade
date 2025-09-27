extends Station

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if(state!="" and state!="cooked"):
		$Icon2/ProgressBar.value+=.12#TESTING PURPOSE BOOST
		if($Icon2/ProgressBar.value>=100 and state!="cooked"):
			state="cooked"
			$AudioStreamPlayer2D2.play()
	if(colliding==true and item==controller.playerInventorySelect and state==""):
		requirementsMet=true
	elif(state=="cooked" and len(controller.playerInventory)<=4 and colliding==true):
		requirementsMet=true
	else:
		requirementsMet=false
	handleVisuals()

	
func interact():
	if(not controller.interactiveItem==self):
		return
	if(state=="cooked"):
		controller.playerInventory.append("cooked rice")
		$"../../Player/PickingUp".play()
		$Icon2.visible=false
		$Icon2/ProgressBar.value=0
		state=""
	elif(item==controller.playerInventorySelect and state==""):
		$AudioStreamPlayer2D.play()
		$Icon2.visible=true
		removeItem("rice")
		state="placed"
