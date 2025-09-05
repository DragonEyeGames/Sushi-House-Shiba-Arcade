extends StaticBody2D

var colliding=false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if($"..".playerInventorySelect==""):
		$RichTextLabel.text=""
		return
	$RichTextLabel.text="Throw Away " + str($"..".playerInventorySelect)
	if($"..".interactiveItem==self):
		$RichTextLabel.visible=colliding
	else:
		$RichTextLabel.visible=false
	if(colliding and Input.is_action_just_pressed("Place")):
		if(not $"..".interactiveItem==self):
			return
		$"..".playerInventory.erase($"..".playerInventorySelect)
		$"..".playerInventorySelect=""
		for i in $"../CanvasLayer".get_children():
			var outline = i.get_node_or_null("Outline")
			if outline:
				outline.visible = false

func _on_area_2d_area_entered(area: Area2D) -> void:
	$"..".interactiveItem=self
	colliding=true


func _on_area_2d_area_exited(area: Area2D) -> void:
	if($"..".interactiveItem==self):
		$"..".interactiveItem=null
	colliding=false
