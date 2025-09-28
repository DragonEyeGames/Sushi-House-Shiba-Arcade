extends Station

@export var stock: float=1
@export var liveCount=false
@export var slideDisplay=false
@export var yBottom=0
@export var yTop=0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	handleVisuals()
	if(liveCount):
		for i in len($"Display".get_children()):
			$"Display".get_children()[i].visible=i+1<=stock
	if(slideDisplay):
		$Control/Display.position.y = lerp(yTop, yBottom, stock/10)
	$RichTextLabel2.text=str(int(round(stock)))
	if(controller.interactiveItem==self):
		if(colliding and ((len(controller.playerInventory)<=4 and stock>0)) or controller.playerInventorySelect==item + " box"):
			requirementsMet=true
		else:
			requirementsMet=false
	else:
		requirementsMet=false

func interact():
	if(not controller.playerInventorySelect==item + " box"):
		if(len(controller.playerInventory)<=4 and stock>=1):
			controller.playerInventory.append(item)
			$"../../Player/PickingUp".play()
			stock-=1
	else:
		controller.placeCurrent(item + " box")
		$"../../Player/SetDown".play()
		if(item=="fish"):
			stock+=$"../../Shipment Container".fish[0]
			$"../../Shipment Container".fish.remove_at(0)
		if(item=="seaweed"):
			stock+=$"../../Shipment Container".seaweed[0]
			$"../../Shipment Container".seaweed.remove_at(0)
		if(item=="rice"):
			stock+=$"../../Shipment Container".rice[0]
			$"../../Shipment Container".rice.remove_at(0)
		if(item=="cucumber"):
			stock+=$"../../Shipment Container".cucumber[0]
			$"../../Shipment Container".cucumber.remove_at(0)
