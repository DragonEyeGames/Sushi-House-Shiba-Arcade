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
	if(placed and not $MinigameHolder.running and $Interactable/RichTextLabel.text=="Fish"):
		$"../Camera2D".following=self
		$"../Camera2D".followingPlayer=false
		$"../Camera2D".Zoom(5)
	# Animate the alpha of the modulate color
		$"../MinigameLayer".visible=true
		for child in $"../CanvasLayer".get_children():
			var t = create_tween()
			t.tween_property(child, "modulate:a", 0.0, 1.0)
		var t = create_tween()
		t.tween_property($"../MinigameLayer/Button", "modulate:a", 1.0, 1.0)
		await get_tree().create_timer(1.1).timeout
		$MinigameHolder.running=true
		return
	elif(placed and not $MinigameHolder.running and $Interactable/RichTextLabel.text!="Fish"):
		if(len($"..".playerInventory)<=4):
			$"..".playerInventory.append($Interactable/RichTextLabel.text.to_lower())
			$Interactable/RichTextLabel.text="Fish"
			placed=false
			placedItem=null
			$Interactable.visible=false
			return
	elif($"..".playerInventorySelect=="fish"):
		placedItem=$"..".playerInventorySelect
		$Interactable/RichTextLabel.text=placedItem
		$Interactable/RichTextLabel.text = $Interactable/RichTextLabel.text.substr(0,1).to_upper() + $Interactable/RichTextLabel.text.substr(1)
		$"..".playerInventory.erase($"..".playerInventorySelect)
		$"..".playerInventorySelect=""
		for i in $"../CanvasLayer".get_children():
			var outline = i.get_node_or_null("Outline")
			if outline:
				outline.visible = false
		$Interactable.visible=true
		placed=true


func _on_button_pressed() -> void:
	$MinigameHolder.running=false
	var t2 = create_tween()
	t2.tween_property($MinigameHolder/Knife, "position", Vector2(42, 35), 1.0)
	$"../Camera2D".followingPlayer=true
	$"../Camera2D".Zoom(1)
	$"../CanvasLayer".visible=true
	#Animate the alpha of the modulate color
	for child in $"../CanvasLayer".get_children():
		var t = create_tween()
		t.tween_property(child, "modulate:a", 1.0, 1.0)
	var t = create_tween()
	t.tween_property($"../MinigameLayer/Button", "modulate:a", 0.0, 1.0)
	await get_tree().create_timer(1).timeout
	$"../MinigameLayer".visible=false
	$"../CanvasLayer".visible=true
