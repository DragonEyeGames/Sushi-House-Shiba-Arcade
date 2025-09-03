extends Node2D

var playerInventorySelect=""
var interactable=""
var interactiveItem
var playerInventory=["rice"]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	for i in range($CanvasLayer.get_child_count()):
		var child = $CanvasLayer.get_child(i)
		if i >= playerInventory.size():
			child.visible=false
		else:
			child.visible=true
	if(Input.is_action_just_pressed("1")):
		if(len(playerInventory)>=1):
			if($"CanvasLayer/1/Outline".visible==false):
				playerInventorySelect=playerInventory[0]
				$"CanvasLayer/1/Outline".visible=true
			else:
				playerInventorySelect=""
				$"CanvasLayer/1/Outline".visible=false
	if(Input.is_action_just_pressed("Place") and interactable!=""):
		interactiveItem.interact()
