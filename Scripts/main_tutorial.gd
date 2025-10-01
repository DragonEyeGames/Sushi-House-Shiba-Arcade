extends Node2D

@export var tutorial=true
var page = 0
var waitingFor=""
var riceSelected=false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if(tutorial):
		$"../Player".canMove=false
		$".".visible=true
		
	else:
		visible=false
		
func _process(_delta: float) -> void:
	print(waitingFor)
	if(waitingFor=="ingredients"):
		if("rice" in $"..".playerInventory and "seaweed" in $"..".playerInventory and "fish" in $"..".playerInventory):
			_on_next_pressed()
	elif(waitingFor=="rice"):
		if($"..".interactiveItem!=null):
			if("stove" in  $"..".interactiveItem.name.to_lower() and Input.is_action_just_pressed("Place") and riceSelected):
				_on_next_pressed()
			else:
				$"..".interactiveItem.name.to_lower()
		riceSelected=$"..".playerInventorySelect=="rice"


func _on_next_pressed() -> void:
	page+=1
	if(page==1):
		$"../TV".add_tutorial_order()
		$CanvasLayer/ColorRect/RichTextLabel.text="In this tutorial you will be taught how to make some food! Looks like someone ordered some sushi so lets make that!"
	elif(page==2):
		$"../Player".canMove=true
		$CanvasLayer/ColorRect/Next.visible=false
		$Sprite2D.visible=true
		$Sprite2D2.visible=true
		$Sprite2D3.visible=true
		$CanvasLayer/ColorRect/Hide.visible=true
		waitingFor="ingredients"
		$CanvasLayer/ColorRect/RichTextLabel.text="First lets get the ingredients! Pick up some rice, seaweed, and fish from their respective bins. Just click to pick them up! You can have up to 5 things in your inventory."
		await get_tree().create_timer(7).timeout
		$CanvasLayer.visible=false
	elif(page==3):
		$CanvasLayer.visible=true
		$Sprite2D.visible=false
		$Sprite2D2.visible=false
		$Sprite2D3.visible=false
		$Sprite2D4.visible=true
		$CanvasLayer/ColorRect/RichTextLabel.text="Now that we have all of our ingredients its time to start processing them! Select you rice using the number keys and then click when by one of the rice cookers to start cooking!"
		waitingFor="rice"
		await get_tree().create_timer(7).timeout
		$CanvasLayer.visible=false
	elif(page==4):
		$CanvasLayer.visible=true
		$Sprite2D4.visible=false
		$CanvasLayer/ColorRect/RichTextLabel.text="Our rice is now cooking! That will take a minute to cook so while it's doing that lets slice up our fish! Head over here with fish selected and click to start cutting!"
		waitingFor="fish"
		await get_tree().create_timer(7).timeout
		$CanvasLayer.visible=false


func _on_hide_pressed() -> void:
	$CanvasLayer.visible=false
