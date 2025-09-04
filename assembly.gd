extends StaticBody2D

var colliding=false

@export var item = "seaweed"

var seaweedPlaced=false
var ricePlaced=false
var fishPlaced=false

var currentItem=""

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(colliding and item==$"..".playerInventorySelect and seaweedPlaced==false):
		$RichTextLabel.visible=true
		$"..".interactable="assembly board"
		$"..".interactiveItem=self
	elif(colliding and item==$"..".playerInventorySelect and ricePlaced==false):
		$RichTextLabel.visible=true
		$RichTextLabel.text="Place Cooked Rice"
		$"..".interactable="assembly board"
		$"..".interactiveItem=self
	elif(colliding and item==$"..".playerInventorySelect and fishPlaced==false):
		$RichTextLabel.visible=true
		$RichTextLabel.text="Place Salmon"
		$"..".interactable="assembly board"
		$"..".interactiveItem=self
	elif(colliding and item!=$"..".playerInventorySelect and len($"..".playerInventory)<=4 and currentItem!=""):
		$RichTextLabel.visible=true
		$RichTextLabel.text="Pickup " + str(currentItem)
		$"..".interactable="assembly board"
		$"..".interactiveItem=self
	else:
		$RichTextLabel.visible=false


func _on_area_2d_area_entered(area: Area2D) -> void:
	colliding=true


func _on_area_2d_area_exited(area: Area2D) -> void:
	if(colliding and item==$"..".playerInventorySelect):
		$RichTextLabel.visible=false
		$"..".interactable=""
		$"..".interactiveItem=null
	colliding=false
	
func interact():
	if(item!=$"..".playerInventorySelect):
		if(colliding and item!=$"..".playerInventorySelect and len($"..".playerInventory)<=4 and currentItem!=""):
			if(len($"..".playerInventory)<=4):
				$"..".playerInventory.append(currentItem)
				currentItem=""
				$Seaweed.visible=false
				$Onigiri.visible=false
				$Sushi.visible=false
				seaweedPlaced=false
				ricePlaced=false
				fishPlaced=false
	if(item=="cooked rice"):
		$"..".playerInventory.erase($"..".playerInventorySelect)
		$"..".playerInventorySelect=""
		for i in $"../CanvasLayer".get_children():
			var outline = i.get_node_or_null("Outline")
			if outline:
				outline.visible = false
		$Onigiri.visible=true
		$Seaweed.visible=false
		ricePlaced=true
		item="fish"
		currentItem="onigiri"
	elif(item=="fish"):
		$"..".playerInventory.erase($"..".playerInventorySelect)
		$"..".playerInventorySelect=""
		for i in $"../CanvasLayer".get_children():
			var outline = i.get_node_or_null("Outline")
			if outline:
				outline.visible = false
		$Sushi.visible=true
		$Onigiri.visible=false
		fishPlaced=true
		item="seaweed"
		currentItem="sushi"
	elif(item=="seaweed"):
		$"..".playerInventory.erase($"..".playerInventorySelect)
		$"..".playerInventorySelect=""
		for i in $"../CanvasLayer".get_children():
			var outline = i.get_node_or_null("Outline")
			if outline:
				outline.visible = false
		$Seaweed.visible=true
		seaweedPlaced=true
		currentItem="seaweed"
		item="cooked rice"
