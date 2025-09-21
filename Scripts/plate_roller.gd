extends Control

@export var rolling=false
var speed = 400
var _currentDelta
var currentPlate
var colliding=false
var replenishing=false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	currentPlate=$"../Sushi Rollers/Control/Plate"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(colliding and $"..".playerInventorySelect!="" and len($"..".playerInventory)>0 and not replenishing):
		currentPlate.get_child(0).material.set_shader_parameter("outline_size", GameManager.outlineSize)
	else:
		currentPlate.get_child(0).material.set_shader_parameter("outline_size", 0)
	if(colliding and $"..".playerInventorySelect!="" and len($"..".playerInventory)>0 and Input.is_action_just_pressed("Place") and not replenishing and not rolling):
		for child in currentPlate.get_child(0).get_children():
			child.visible=child.name==$"..".playerInventorySelect
		$"..".placeCurrent("current")
		rolling=true
	if(rolling):
		$RollBars.position.x-=speed*delta
		$RollBars2.position.x-=speed*delta
		$RollBars3.position.x-=speed*delta
		if($RollBars3.position.x<-98):
			$RollBars3.position.x=249
		if($RollBars2.position.x<-98):
			$RollBars2.position.x=249
		if($RollBars.position.x<-98):
			$RollBars.position.x=249
		currentPlate.position.x-=speed*delta
		if(currentPlate.position.x<=64):
			currentPlate.position.x=64
			rolling=false
			currentPlate.reparent($"../Sushi Rollers/Control/Path2D")
			currentPlate.get_child(0).material.set_shader_parameter("outline_size", 0)
			currentPlate=$"../Sushi Rollers/Control/Plate2".duplicate()
			$"../Sushi Rollers/Control".add_child(currentPlate)
			currentPlate.get_child(0).material=currentPlate.get_child(0).material.duplicate()
			replenishing=true
	if(replenishing):
		currentPlate.position.y+=speed*delta
		if(currentPlate.position.y>=60):
			currentPlate.position.y=60
			replenishing=false

func getPlate():
	pass


func _on_area_2d_area_entered(_area: Area2D) -> void:
	colliding=true


func _on_area_2d_area_exited(_area: Area2D) -> void:
	colliding=false
