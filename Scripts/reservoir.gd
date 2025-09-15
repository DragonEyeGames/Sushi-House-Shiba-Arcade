extends Sprite2D

var colliding=false

@export var item = ""
@export var stock=1
@export var controller: Node2D
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$RichTextLabel2.visible=false
	if(controller.interactiveItem==self):
		if(colliding and len(controller.playerInventory)<=4):
			self.material.set_shader_parameter("outline_size", 1.4)
		else:
			self.material.set_shader_parameter("outline_size", 0)
	else:
		self.material.set_shader_parameter("outline_size", 0)
	if(colliding and Input.is_action_just_pressed("Place")):
		if(not controller.interactiveItem==self):
			return
		if(len(controller.playerInventory)<=4):
			controller.playerInventory.append(item)
			$"../../Player/PickingUp".play()
			stock-=1

func _on_area_2d_area_entered(area: Area2D) -> void:
	controller.interactiveItem=self
	colliding=true


func _on_area_2d_area_exited(area: Area2D) -> void:
	if(controller.interactiveItem==self):
		controller.interactiveItem=null
	colliding=false
