extends Node2D

var playerInventorySelect=""
var interactable=""
var interactiveItem
var playerInventory=[]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
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
		
	if(Input.is_action_just_pressed("1")):
		if(len(playerInventory)>=1):
			if($"CanvasLayer/1/Outline".visible==false):
				for i in $CanvasLayer.get_children():
					var outline = i.get_node_or_null("Outline")
					if outline:
						outline.visible = false
				playerInventorySelect=playerInventory[0]
				$"CanvasLayer/1/Outline".visible=true
				for child in $"CanvasLayer/1/Items".get_children():
					child.visible=false
				var item = $"CanvasLayer/1/Items".get_node(playerInventorySelect)
				item.visible=true
			else:
				playerInventorySelect=""
				$"CanvasLayer/1/Outline".visible=false
	if(Input.is_action_just_pressed("2")):
		if(len(playerInventory)>=2):
			if($"CanvasLayer/2/Outline".visible==false):
				for i in $CanvasLayer.get_children():
					var outline = i.get_node_or_null("Outline")
					if outline:
						outline.visible = false
				playerInventorySelect=playerInventory[1]
				$"CanvasLayer/2/Outline".visible=true
				for child in $"CanvasLayer/2/Items".get_children():
					child.visible=false
				var item = $"CanvasLayer/2/Items".get_node(playerInventorySelect)
				item.visible=true
			else:
				playerInventorySelect=""
				$"CanvasLayer/2/Outline".visible=false
	if(Input.is_action_just_pressed("3")):
		if(len(playerInventory)>=3):
			if($"CanvasLayer/3/Outline".visible==false):
				for i in $CanvasLayer.get_children():
					var outline = i.get_node_or_null("Outline")
					if outline:
						outline.visible = false
				playerInventorySelect=playerInventory[2]
				$"CanvasLayer/3/Outline".visible=true
				for child in $"CanvasLayer/3/Items".get_children():
					child.visible=false
				var item = $"CanvasLayer/3/Items".get_node(playerInventorySelect)
				item.visible=true
			else:
				playerInventorySelect=""
				$"CanvasLayer/3/Outline".visible=false
	if(Input.is_action_just_pressed("4")):
		if(len(playerInventory)>=4):
			if($"CanvasLayer/4/Outline".visible==false):
				for i in $CanvasLayer.get_children():
					var outline = i.get_node_or_null("Outline")
					if outline:
						outline.visible = false
				playerInventorySelect=playerInventory[3]
				$"CanvasLayer/4/Outline".visible=true
				for child in $"CanvasLayer/4/Items".get_children():
					child.visible=false
				var item = $"CanvasLayer/4/Items".get_node(playerInventorySelect)
				item.visible=true
			else:
				playerInventorySelect=""
				$"CanvasLayer/4/Outline".visible=false
	if(Input.is_action_just_pressed("5")):
		if(len(playerInventory)>=5):
			if($"CanvasLayer/5/Outline".visible==false):
				for i in $CanvasLayer.get_children():
					var outline = i.get_node_or_null("Outline")
					if outline:
						outline.visible = false
				playerInventorySelect=playerInventory[4]
				$"CanvasLayer/5/Outline".visible=true
				for child in $"CanvasLayer/5/Items".get_children():
					child.visible=false
				var item = $"CanvasLayer/5/Items".get_node(playerInventorySelect)
				item.visible=true
			else:
				playerInventorySelect=""
				$"CanvasLayer/5/Outline".visible=false
	if(Input.is_action_just_pressed("Place") and interactable!=""):
		interactiveItem.interact()
