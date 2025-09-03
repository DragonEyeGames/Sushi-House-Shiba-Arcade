extends StaticBody2D

var colliding=false

@export var item = ""
@export var stock=1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$RichTextLabel2.text=str(stock)
	$RichTextLabel.visible=colliding and len($"..".playerInventory)<=4 and stock>=1
	if(colliding and Input.is_action_just_pressed("Place") and stock>=1):
		if(len($"..".playerInventory)<=4):
			$"..".playerInventory.append(item)
			stock-=1

func _on_area_2d_area_entered(area: Area2D) -> void:
	colliding=true


func _on_area_2d_area_exited(area: Area2D) -> void:
	colliding=false
	
func interact():
	$"..".playerInventory.erase($"..".playerInventorySelect)
	$"..".playerInventorySelect=""
	$Interactable.visible=true
