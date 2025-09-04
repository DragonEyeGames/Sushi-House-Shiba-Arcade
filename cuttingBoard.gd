extends StaticBody2D

var colliding=false

@export var item = ""

var placed=false
var placedItem

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(colliding and item==$"..".playerInventorySelect and placed==false):
		$RichTextLabel.visible=true
		$"..".interactable="cutting board"
		$"..".interactiveItem=self
	elif(colliding and placed):
		$RichTextLabel.visible=true
		$RichTextLabel.text="Cut " + placedItem
		$"..".interactable="cutting board"
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
	if(placed):
		$"../Camera2D".following=self
		$"../Camera2D".followingPlayer=false
		$"../Camera2D".Zoom(5)
		await get_tree().create_timer(1.1).timeout
		$MinigameHolder.visible=true
		$MinigameHolder.running=true
		$"../CanvasLayer".visible=false
		return
	placedItem=$"..".playerInventorySelect
	$"..".playerInventory.erase($"..".playerInventorySelect)
	$"..".playerInventorySelect=""
	for i in $"../CanvasLayer".get_children():
		var outline = i.get_node_or_null("Outline")
		if outline:
			outline.visible = false
	$Interactable.visible=true
	placed=true
