extends StaticBody2D

var colliding=false

@export var item = ""
@export var stock=1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$RichTextLabel2.visible=false
	if($"..".interactiveItem==self):
		$RichTextLabel.visible=colliding and len($"..".playerInventory)<=4
	else:
		$RichTextLabel.visible=false
	if(colliding and Input.is_action_just_pressed("Place")):
		if(not $"..".interactiveItem==self):
			return
		if(len($"..".playerInventory)<=4):
			$"..".playerInventory.append(item)
			$"../Player/PickingUp".play()
			stock-=1

func _on_area_2d_area_entered(area: Area2D) -> void:
	$"..".interactiveItem=self
	colliding=true


func _on_area_2d_area_exited(area: Area2D) -> void:
	if($"..".interactiveItem==self):
		$"..".interactiveItem=null
	colliding=false
	
func interact():
	if(not $"..".interactiveItem==self):
		return
	$"..".playerInventory.erase($"..".playerInventorySelect)
	$"..".playerInventorySelect=""
	$Interactable.visible=true
