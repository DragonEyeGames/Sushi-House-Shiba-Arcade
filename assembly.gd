extends StaticBody2D

var colliding=false

@export var item = "seaweed"

var seaweedPlaced=false
var ricePlaced=false
var fishPlaced=false

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
	elif(item=="seaweed"):
		$"..".playerInventory.erase($"..".playerInventorySelect)
		$"..".playerInventorySelect=""
		for i in $"../CanvasLayer".get_children():
			var outline = i.get_node_or_null("Outline")
			if outline:
				outline.visible = false
		$Seaweed.visible=true
		seaweedPlaced=true
		item="cooked rice"
