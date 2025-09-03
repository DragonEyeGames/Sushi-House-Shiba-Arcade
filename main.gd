extends Node2D

var playerInventorySelect=""
var interactable=""
var interactiveItem
var playerInventory=["fish", "rice", "seaweed", "cooked rice"]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	for i in range($CanvasLayer.get_child_count()):
		var child = $CanvasLayer.get_child(i)
		if i >= playerInventory.size():
			child.visible=false
		else:
			child.visible=true
			
	if(len(playerInventory)>=1):
		$"CanvasLayer/1/rice".visible=false
		$"CanvasLayer/1/fish".visible=false
		$"CanvasLayer/1/cooked rice".visible=false
		$"CanvasLayer/1/seaweed".visible=false
		var item = $"CanvasLayer/1".get_node(playerInventory[0])
		item.visible=true
	if(len(playerInventory)>=2):
		$"CanvasLayer/2/rice".visible=false
		$"CanvasLayer/2/fish".visible=false
		$"CanvasLayer/2/cooked rice".visible=false
		$"CanvasLayer/2/seaweed".visible=false
		var item = $"CanvasLayer/2".get_node(playerInventory[1])
		item.visible=true
	if(len(playerInventory)>=3):
		$"CanvasLayer/3/rice".visible=false
		$"CanvasLayer/3/fish".visible=false
		$"CanvasLayer/3/cooked rice".visible=false
		$"CanvasLayer/3/seaweed".visible=false
		var item = $"CanvasLayer/3".get_node(playerInventory[2])
		item.visible=true
	if(len(playerInventory)>=4):
		$"CanvasLayer/4/rice".visible=false
		$"CanvasLayer/4/fish".visible=false
		$"CanvasLayer/4/cooked rice".visible=false
		$"CanvasLayer/4/seaweed".visible=false
		var item = $"CanvasLayer/4".get_node(playerInventory[3])
		item.visible=true
	if(len(playerInventory)>=5):
		$"CanvasLayer/5/rice".visible=false
		$"CanvasLayer/5/fish".visible=false
		$"CanvasLayer/5/cooked rice".visible=false
		$"CanvasLayer/5/seaweed".visible=false
		var item = $"CanvasLayer/5".get_node(playerInventory[4])
		item.visible=true
		
	if(Input.is_action_just_pressed("1")):
		if(len(playerInventory)>=1):
			if($"CanvasLayer/1/Outline".visible==false):
				for i in $CanvasLayer.get_children():
					var outline = i.get_node_or_null("Outline")
					if outline:
						outline.visible = false
				playerInventorySelect=playerInventory[0]
				$"CanvasLayer/1/Outline".visible=true
				$"CanvasLayer/1/rice".visible=false
				$"CanvasLayer/1/fish".visible=false
				var item = $"CanvasLayer/1".get_node(playerInventorySelect)
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
				$"CanvasLayer/2/rice".visible=false
				$"CanvasLayer/2/fish".visible=false
				var item = $"CanvasLayer/2".get_node(playerInventorySelect)
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
				$"CanvasLayer/3/rice".visible=false
				$"CanvasLayer/3/fish".visible=false
				var item = $"CanvasLayer/3".get_node(playerInventorySelect)
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
				$"CanvasLayer/4/rice".visible=false
				$"CanvasLayer/4/fish".visible=false
				var item = $"CanvasLayer/4".get_node(playerInventorySelect)
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
				$"CanvasLayer/5/rice".visible=false
				$"CanvasLayer/5/fish".visible=false
				var item = $"CanvasLayer/5".get_node(playerInventorySelect)
				item.visible=true
			else:
				playerInventorySelect=""
				$"CanvasLayer/5/Outline".visible=false
	if(Input.is_action_just_pressed("Place") and interactable!=""):
		interactiveItem.interact()
