extends Node2D

var playerInventorySelect=""
var interactable=""
var interactiveItem
var playerInventory=[]
var score = 0
var selectedSlot=-1
var controller=false
var outlineSize=2.4

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var joypads = Input.get_connected_joypads()
	if joypads.size() > 0:
		controller=true
	GameManager.player=$Player
	GameManager.camera=$Camera2D
	GameManager.canvasLayer=$CanvasLayer
	GameManager.scoreLayer=$Score


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if(Input.is_action_just_pressed("1")):
		selectedSlot=0
	if(Input.is_action_just_pressed("2")):
		selectedSlot=1
	if(Input.is_action_just_pressed("3")):
		selectedSlot=2
	if(Input.is_action_just_pressed("4")):
		selectedSlot=3
	if(Input.is_action_just_pressed("5")):
		selectedSlot=4
	if(Input.is_action_just_pressed("InvLeft")):
		selectedSlot-=1
		if(selectedSlot<0):
			selectedSlot=len(playerInventory)-1
	if(Input.is_action_just_pressed("InvRight")):
		selectedSlot+=1
		if(selectedSlot>len(playerInventory)-1):
			selectedSlot=0
	if(len(playerInventory)==0):
		selectedSlot=-1
		playerInventorySelect=""
	if(len(playerInventory)>0 and selectedSlot==-1):
		selectedSlot=0
	if(len(playerInventory)<(selectedSlot+1)):
		selectedSlot=len(playerInventory)-1
	$Score/RichTextLabel2.text=str(score)
	for i in range($CanvasLayer.get_child_count()):
		var child = $CanvasLayer.get_child(i)
		if i >= playerInventory.size():
			if(child.name!="Outline"):
				child.visible=false
		else:
			child.visible=true
	#Visibility mod
	for i in range($CanvasLayer.get_child_count()):
		var slot = $CanvasLayer.get_child(i).get_child(2)

		# Hide everything in this slot first
		for child in slot.get_children():
			child.visible = false

		# Show the player's inventory item if it exists for this slot
		if i < playerInventory.size():
			var item_name = playerInventory[i]
			var item_node = slot.get_node_or_null(item_name)
			if item_node:
				item_node.visible = true
		
	if(selectedSlot==0):
		if(len(playerInventory)>=1):
			playerInventorySelect=playerInventory[0]
			$"CanvasLayer/1/Outline".visible=true
			for child in $"CanvasLayer/1/Items".get_children():
				child.visible=false
			var item = $"CanvasLayer/1/Items".get_node(playerInventorySelect)
			item.visible=true
	else:
		$"CanvasLayer/1/Outline".visible=false
	if(selectedSlot==1):
		if(len(playerInventory)>=2):
			playerInventorySelect=playerInventory[1]
			$"CanvasLayer/2/Outline".visible=true
			for child in $"CanvasLayer/2/Items".get_children():
				child.visible=false
			var item = $"CanvasLayer/2/Items".get_node(playerInventorySelect)
			item.visible=true
	else:
		$"CanvasLayer/2/Outline".visible=false
	if(selectedSlot==2):
		if(len(playerInventory)>=3):
			playerInventorySelect=playerInventory[2]
			$"CanvasLayer/3/Outline".visible=true
			for child in $"CanvasLayer/3/Items".get_children():
				child.visible=false
			var item = $"CanvasLayer/3/Items".get_node(playerInventorySelect)
			item.visible=true
	else:
		$"CanvasLayer/3/Outline".visible=false
	if(selectedSlot==3):
		if(len(playerInventory)>=4):
			playerInventorySelect=playerInventory[3]
			$"CanvasLayer/4/Outline".visible=true
			for child in $"CanvasLayer/4/Items".get_children():
				child.visible=false
			var item = $"CanvasLayer/4/Items".get_node(playerInventorySelect)
			item.visible=true
	else:
		$"CanvasLayer/4/Outline".visible=false
	if(selectedSlot==4):
		if(len(playerInventory)>=5):
			playerInventorySelect=playerInventory[4]
			$"CanvasLayer/5/Outline".visible=true
			for child in $"CanvasLayer/5/Items".get_children():
				child.visible=false
			var item = $"CanvasLayer/5/Items".get_node(playerInventorySelect)
			item.visible=true
	else:
		$"CanvasLayer/5/Outline".visible=false
	if(Input.is_action_just_pressed("Place") and interactable!=""):
		interactiveItem.interact()
		
func placeCurrent(item):
	if(item=="current"):
		playerInventory.remove_at(selectedSlot)
	else:
		playerInventory.erase(item)
	$Player/SetDown.play()


func on_cucumber_entered(_area: Area2D) -> void:
	pass # Replace with function body.
