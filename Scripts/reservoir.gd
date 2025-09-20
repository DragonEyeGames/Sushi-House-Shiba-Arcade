extends Sprite2D

var colliding=false

@export var item = ""
@export var stock=1
@export var controller: Node2D
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	$RichTextLabel2.text=str(stock)
	if(controller.interactiveItem==self):
		if(colliding and len(controller.playerInventory)<=4):
			self.material.set_shader_parameter("outline_size", GameManager.outlineSize)
		else:
			self.material.set_shader_parameter("outline_size", 0)
	else:
		self.material.set_shader_parameter("outline_size", 0)
	if(colliding and Input.is_action_just_pressed("Place")):
		if(not controller.interactiveItem==self):
			return
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

func _on_area_2d_area_entered(_area: Area2D) -> void:
	controller.interactiveItem=self
	colliding=true


func _on_area_2d_area_exited(_area: Area2D) -> void:
	if(controller.interactiveItem==self):
		controller.interactiveItem=null
	colliding=false
