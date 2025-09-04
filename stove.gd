extends StaticBody2D

var colliding=false

@export var item = "rice"

var placed=false
var cooked=false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(placed):
		$Interactable/ProgressBar.value+=.05 * 1000#TESTING PURPOSE BOOST
		if($Interactable/ProgressBar.value>=100):
			cooked=true
	if(colliding and item==$"..".playerInventorySelect and placed==false):
		$RichTextLabel.visible=true
		$"..".interactable="rice stove"
		$"..".interactiveItem=self
	elif(cooked and len($"..".playerInventory)<=4):
		if(colliding):
			$RichTextLabel.visible=true
		$"RichTextLabel".text="Grab Pot"
		$"..".interactable="rice stove"
		$"..".interactiveItem=self
	else:
		$RichTextLabel.visible=false


func _on_area_2d_area_entered(area: Area2D) -> void:
	colliding=true


func _on_area_2d_area_exited(area: Area2D) -> void:
	$RichTextLabel.visible=false
	$"..".interactable=""
	$"..".interactiveItem=null
	colliding=false
	
func interact():
	if(cooked):
		$"..".playerInventory.append("cooked rice")
		$"..".playerInventorySelect=""
		for i in $"../CanvasLayer".get_children():
			var outline = i.get_node_or_null("Outline")
			if outline:
				outline.visible = false
		$Interactable.visible=false
		placed=false
		cooked=false
	elif(item==$"..".playerInventorySelect):
		$"..".playerInventory.erase($"..".playerInventorySelect)
		$"..".playerInventorySelect=""
		for i in $"../CanvasLayer".get_children():
			var outline = i.get_node_or_null("Outline")
			if outline:
				outline.visible = false
		$Interactable.visible=true
		placed=true
