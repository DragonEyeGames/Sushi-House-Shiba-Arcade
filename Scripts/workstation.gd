extends StaticBody2D

var colliding=false

@export var item = ""

var placed=false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(colliding and item==$"..".playerInventorySelect and placed==false):
		$RichTextLabel.visible=true
		$"..".interactable="rice stove"
		$"..".interactiveItem=self
	else:
		$RichTextLabel.visible=false


func _on_area_2d_area_entered(area: Area2D) -> void:
	colliding=true


func _on_area_2d_area_exited(area: Area2D) -> void:
	$RichTextLabel.visible=false
	if($"..".interactiveItem==self):
		$"..".interactable=""
		$"..".interactiveItem=null
	colliding=false
	
func interact():
	if(not $"..".interactiveItem==self):
		return
	if(placed):
		return
	$"..".playerInventory.erase($"..".playerInventorySelect)
	$"..".playerInventorySelect=""
	for i in $"../CanvasLayer".get_children():
		var outline = i.get_node_or_null("Outline")
		if outline:
			outline.visible = false
	$Interactable.visible=true
	placed=true
