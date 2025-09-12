extends Control

@export var rolling=false
var speed = 400
var _currentDelta
var currentPlate = []
var plateState = []
var colliding=false
var settingPlate
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	currentPlate.append($"../Plates/Plate2")
	settingPlate=$"../Plates/Plate2"
	plateState.append("idle")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	_currentDelta=delta
	if(colliding):
		$"..".interactiveItem=self
	if(colliding and settingPlate!=null):
		if($"..".playerInventorySelect!=""):
			settingPlate.material.set_shader_parameter("outline_size", 1.4)
			if(Input.is_action_just_pressed("Place")):
				settingPlate.material.set_shader_parameter("outline_size", 0)
				$"../AudioStreamPlayer2D2".playing=true
				if($"..".playerInventorySelect in $"../TV".orders):
					var index=$"../TV".orders.find($"..".playerInventorySelect)
					$"../TV".orders.remove_at(index)
					$"../TV".orderTimeRemaining.remove_at(index)
					$"..".score+=1000
				else:
					$"..".score-=100
					if($"..".score<0):
						$"..".score=0
				var item_node = settingPlate.get_node_or_null($"..".playerInventorySelect)
				if item_node:
					item_node.visible = true
				rolling=true
				settingPlate=null
				$"..".playerInventory.erase($"..".playerInventorySelect)
				$"..".playerInventorySelect=""
				for i in $"../CanvasLayer".get_children():
					var outline = i.get_node_or_null("Outline")
					if outline:
						outline.visible = false
		else:
			settingPlate.material.set_shader_parameter("outline_size", 0)
	else:
		if(settingPlate!=null):
			settingPlate.material.set_shader_parameter("outline_size", 0)
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
	for plate in currentPlate:
		var index = currentPlate.find(plate)
		if(plateState[index]=="idle" and rolling):
			plateState[index]="rolling"
		if(plate.position.x<=-297 and plateState[index]=="gliding"):
			plate.position.x=-297
			plate.position.y+=80*delta
		elif(plateState[index]=="rolling"):
			plate.position.x-=speed*delta
			if(plate.position.x<=-297):
				plate.position.x=-297
				getPlate()
				rolling=false
				plateState[index]="gliding"
func getPlate():
	var plate = $"../Plates/Plate".duplicate()
	plate.material = plate.material.duplicate()
	$"../Plates".add_child(plate)
	plate.z_index=15
	plate.visible=true
	settingPlate=null
	while plate.position.y<-117:
		plate.position.y+=speed/2*_currentDelta
		await get_tree().create_timer(0).timeout
	plate.position.y=-117
	settingPlate=plate
	currentPlate.append(plate)
	plateState.append("idle")


func _on_area_2d_area_entered(area: Area2D) -> void:
	colliding=true


func _on_area_2d_area_exited(area: Area2D) -> void:
	colliding=false
