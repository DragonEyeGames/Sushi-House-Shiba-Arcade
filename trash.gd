extends Sprite2D

var colliding=false
@export var controller: Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(controller.playerInventorySelect==""):
		self.material.set_shader_parameter("outline_size", 0)
		return
	if(controller.interactiveItem==self):
		if(colliding and controller.playerInventorySelect!=""):
			self.material.set_shader_parameter("outline_size", 1.4)
		else:
			self.material.set_shader_parameter("outline_size", 0)
	else:
		self.material.set_shader_parameter("outline_size", 0)
	if(colliding and Input.is_action_just_pressed("Place")):
		if(not controller.interactiveItem==self):
			return
		controller.playerInventory.erase(controller.playerInventorySelect)
		controller.playerInventorySelect=""
		for i in $"../../CanvasLayer".get_children():
			var outline = i.get_node_or_null("Outline")
			if outline:
				outline.visible = false

func _on_area_2d_area_entered(area: Area2D) -> void:
	controller.interactiveItem=self
	colliding=true


func _on_area_2d_area_exited(area: Area2D) -> void:
	if(controller.interactiveItem==self):
		controller.interactiveItem=null
	colliding=false
