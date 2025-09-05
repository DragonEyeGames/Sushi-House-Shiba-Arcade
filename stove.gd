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
		$Icon2/ProgressBar.value+=.05#TESTING PURPOSE BOOST
		if($Icon2/ProgressBar.value>=100):
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
	if($"..".interactiveItem==self):
		$"..".interactable=""
		$"..".interactiveItem=null
	colliding=false
	
func interact():
	if(not $"..".interactiveItem==self):
		return
	if(cooked):
		$"..".playerInventory.append("cooked rice")
		$Icon2.visible=false
		$Icon.visible=true
		$Icon2/ProgressBar.value=0
		$"..".playerInventorySelect=""
		for i in $"../CanvasLayer".get_children():
			var outline = i.get_node_or_null("Outline")
			if outline:
				outline.visible = false
		$Interactable.visible=false
		placed=false
		cooked=false
	elif(item==$"..".playerInventorySelect):
		$Icon2.visible=true
		$Icon.visible=false
		$"..".playerInventory.erase($"..".playerInventorySelect)
		$"..".playerInventorySelect=""
		for i in $"../CanvasLayer".get_children():
			var outline = i.get_node_or_null("Outline")
			if outline:
				outline.visible = false
		placed=true
