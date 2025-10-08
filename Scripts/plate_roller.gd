extends Control

@export var rolling=false
var speed = 400
var currentPlate
var colliding=false
var replenishing=false
var plates=4
var platePlaced=false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(currentPlate==null):
		if(colliding and $"..".playerInventorySelect!="" and $"..".playerInventorySelect!="dirty plate" and "meal" in $"..".playerInventorySelect and len($"..".playerInventory)>0 and not replenishing):
			if(Input.is_action_just_pressed("Place")):
				newPlate()
				for child in currentPlate.get_child(0).get_children():
					child.visible=child.name==$"..".playerInventorySelect
					if(child.name in $"../TV".orders and child.visible):
						var index=$"../TV".orders.find(child.name)
						$"../TV".orders.remove_at(index)
						$"../TV".orderTimeRemaining.remove_at(index)
						print(child.name)
						if(child.name=="sushi meal"):
							GameManager.score+=10
						elif(child.name=="onigiri meal"):
							GameManager.score+=6
						elif(child.name=="sushi with cucumber meal"):
							GameManager.score+=14
						elif(child.name=="onigiri with cucumber meal"):
							GameManager.score+=8
						elif(child.name=="sliced fish meal"):
							GameManager.score+=5
						elif(child.name=="cooked rice meal"):
							GameManager.score+=2
						elif(child.name=="cooked rice with sliced cucumber meal"):
							GameManager.score+=6
						elif(child.name=="cooked rice with sliced fish meal"):
							GameManager.score+=8
						elif(child.name=="sliced cucumber with sliced fish meal"):
							GameManager.score+=10
						elif(child.name=="sliced cucumber meal"):
							GameManager.score+=4
						$"../TV".orderSpeed-=.4
				$"..".placeCurrent("current")
				rolling=true
				platePlaced=false
				currentPlate.get_child(0).rolling=true
	if(colliding and $"..".playerInventorySelect!="" and $"..".playerInventorySelect=="plate" and len($"..".playerInventory)>0 and Input.is_action_just_pressed("Place") and not platePlaced):
		$"..".placeCurrent("plate")
		newPlate()
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
			currentPlate=null
	if(replenishing):
		currentPlate.position.y+=speed*delta
		if(currentPlate.position.y>=60):
			currentPlate.position.y=60
			replenishing=false

func getPlate():
	pass

func newPlate():
	platePlaced=true
	currentPlate=$"../Sushi Rollers/Control/Plate".duplicate()
	$"../Sushi Rollers/Control".add_child(currentPlate)
	currentPlate.visible=true
	currentPlate.get_child(0).material=currentPlate.get_child(0).material.duplicate()
	currentPlate.name="Plate"

func _on_area_2d_area_entered(_area: Area2D) -> void:
	colliding=true


func _on_area_2d_area_exited(_area: Area2D) -> void:
	colliding=false
