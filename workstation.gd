extends StaticBody2D

var colliding=false

@export var item = ""

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(colliding and item==$"..".playerInventorySelect):
		$RichTextLabel.visible=true
		$"..".interactable="rice stove"
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
	$"..".playerInventory.erase($"..".playerInventorySelect)
	$"..".playerInventorySelect=""
	$Interactable.visible=true
