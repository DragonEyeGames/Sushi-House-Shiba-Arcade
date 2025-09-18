extends Node2D

var rising = false
var area1=false
var area2=false
var interacting=[]
var itemTypes = ["fish", "seaweed"]
@export var fish = 5
@export var seaweed = 5
@export var rice = 5
@export var cucumber = 5
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	shipment()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(rising):
		for child in $Control.get_children():
			child.position.y-=120*delta
	if(len(interacting)==1):
		if(interacting[0]=="1"):
			area1=true
			area2=false
		elif(interacting[0]=="2"):
			area1=false
			area2=true
	if(area1):
		$"../Box".material.set_shader_parameter("outline_size", 2)
	else:
		$"../Box".material.set_shader_parameter("outline_size", 0)
	if(area2):
		$"../Box2".material.set_shader_parameter("outline_size", 2)
	else:
		$"../Box2".material.set_shader_parameter("outline_size", 0)
		
	if(Input.is_action_just_pressed("Place")):
		if(area1):
			$"../Box".visible=false
			$"../Box/Area2D/CollisionShape2D".disabled=true
			$"../Box/StaticBody2D/CollisionShape2D".disabled=false
			if(itemTypes[0]=="fish"):
				if(len($"..".playerInventory)<=4):
					$"..".playerInventory.append("fish box")
					$"../Player/PickingUp".play()
		elif(area2):
			$"../Box2".visible=false
			$"../Box2/StaticBody2D/CollisionShape2D".disabled=true
			$"../Box2/Area2D/CollisionShape2D".disabled=true
	
func shipment():
	rising=true


func _1_entered(area: Area2D) -> void:
	area1=true
	interacting.append("1")
	area2=false


func _1_exited(area: Area2D) -> void:
	area1=false
	interacting.erase("1")


func _2_entered(area: Area2D) -> void:
	area2=true
	area1=false
	interacting.append("2")


func _2_exited(area: Area2D) -> void:
	area2=false
	interacting.erase("2")
