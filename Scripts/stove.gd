extends Sprite2D

var colliding=false

@export var item = "rice"
@export var controller: Node2D
var placed=false
var cooked=false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(placed):
		$Icon2/ProgressBar.value+=1.12#TESTING PURPOSE BOOST
		if($Icon2/ProgressBar.value>=100 and cooked==false):
			cooked=true
			$AudioStreamPlayer2D2.play()
	if(colliding and item==controller.playerInventorySelect and placed==false):
		self.material.set_shader_parameter("outline_size", 1.4)
		controller.interactable="rice stove"
		controller.interactiveItem=self
	elif(cooked and len(controller.playerInventory)<=4):
		if(colliding):
			self.material.set_shader_parameter("outline_size", 1.4)
			controller.interactable="rice stove"
			controller.interactiveItem=self
	else:
		self.material.set_shader_parameter("outline_size", 0)


func _on_area_2d_area_entered(area: Area2D) -> void:
	colliding=true


func _on_area_2d_area_exited(area: Area2D) -> void:
	self.material.set_shader_parameter("outline_size", 0)
	if(controller.interactiveItem==self):
		controller.interactable=""
		controller.interactiveItem=null
	colliding=false
	
func interact():
	if(not controller.interactiveItem==self):
		return
	if(cooked):
		controller.playerInventory.append("cooked rice")
		$"../../Player/PickingUp".play()
		$Icon2.visible=false
		$Icon2/ProgressBar.value=0
		placed=false
		cooked=false
	elif(item==controller.playerInventorySelect and not placed):
		$AudioStreamPlayer2D.play()
		$Icon2.visible=true
		controller.placeCurrent("rice")
		placed=true
