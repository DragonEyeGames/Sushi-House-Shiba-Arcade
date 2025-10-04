extends Node2D

@export var tutorial=true
var page = 0
var waitingFor=""
var riceSelected=false
var fishSelected=false
var seaweedSelected

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if(tutorial):
		$"../Player".canMove=false
		$".".visible=true
		$CanvasLayer.visible=true
		
	else:
		visible=false
		
func _process(_delta: float) -> void:
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
	elif(waitingFor=="fish"):
		if($"..".interactiveItem!=null):
			if("cutting board" in  $"..".interactiveItem.name.to_lower() and Input.is_action_just_pressed("Place") and fishSelected):
				_on_next_pressed()
			else:
				$"..".interactiveItem.name.to_lower()
		fishSelected=$"..".playerInventorySelect=="fish"
	elif(waitingFor=="cutting"):
		if("sliced fish" in $"..".playerInventory):
			_on_next_pressed()
	elif(waitingFor=="cookedRice"):
		if("cooked rice" in $"..".playerInventory):
			_on_next_pressed()
	elif(waitingFor=="assembly"):
		if($"..".interactiveItem!=null):
			if("assembly" in  $"..".interactiveItem.name.to_lower() and Input.is_action_just_pressed("Place") and seaweedSelected):
				_on_next_pressed()
			else:
				$"..".interactiveItem.name.to_lower()
		seaweedSelected=$"..".playerInventorySelect=="seaweed"
	elif(waitingFor=="onigiri"):
		if($"../Stations/Assembly Board/Display Items/Rice".visible==true):
			_on_next_pressed()
	elif(waitingFor=="finishedAssembly"):
		if("sushi" in $"..".playerInventory):
			_on_next_pressed()
	elif(waitingFor=="plate"):
		if("plate" in $"..".playerInventory):
			_on_next_pressed()
	elif(waitingFor=="placed"):
		if($"../Plate Roller".currentPlate!=null):
			_on_next_pressed()
	elif(waitingFor=="shipped"):
		if($"../Plate Roller".currentPlate.get_child(0).rolling):
			_on_next_pressed()
	elif(waitingFor=="dirtyPlate"):
		if("dirty plate" in $"..".playerInventory):
			_on_next_pressed()
		else:
			print($"..".playerInventory)
	elif(waitingFor=="placedDirty"):
		if(not "dirty plate" in $"..".playerInventory):
			_on_next_pressed()


func _on_next_pressed() -> void:
	page+=1
	if(page==1):
		$"../TV".add_tutorial_order()
		$CanvasLayer/ColorRect/RichTextLabel.text="In this tutorial you will be taught how to make some food! Looks like someone ordered some sushi so lets make that!"
	elif(page==2):
		$CanvasLayer/ColorRect/Quit.visible=false
		$"../Player".canMove=true
		$"../Stations/Cucumber Reservoir/Area2D/CollisionShape2D".disabled=true
		$"../Stations/Cutting Board/Area2D/CollisionShape2D".disabled=true
		$"../Stations/Assembly Board/Area2D/CollisionShape2D".disabled=true
		$"../Stations/Stove/Area2D/CollisionShape2D".disabled=true
		$"../Stations/Stove2/Area2D/CollisionShape2D".disabled=true
		$"../Stations/Sink/Area2D/CollisionShape2D".disabled=true
		$"../Stations/Desk/Area2D/CollisionShape2D".disabled=true
		$"../Plate Roller/Rollers/Area2D/CollisionShape2D".disabled=true
		$"../Area2D/CollisionShape2D".disabled=true
		$CanvasLayer/ColorRect/Next.visible=false
		$Sprite2D.visible=true
		$Sprite2D2.visible=true
		$Sprite2D3.visible=true
		$CanvasLayer/ColorRect/Hide.visible=true
		waitingFor="ingredients"
		$CanvasLayer/ColorRect/RichTextLabel.text="First lets get the ingredients! Pick up some rice, seaweed, and fish from their respective bins. Just click to pick them up! You can have up to 5 things in your inventory. You can also press hide to hide this message until you're done."

	elif(page==3):
		$CanvasLayer.visible=true
		$Sprite2D.visible=false
		$Sprite2D2.visible=false
		$Sprite2D3.visible=false
		$Sprite2D4.visible=true
		$"../Stations/Seaweed Reservoir/Area2D/CollisionShape2D".disabled=true
		$"../Stations/Fish Reservoir/Area2D/CollisionShape2D".disabled=true
		$"../Stations/Rice Reservoir/Area2D/CollisionShape2D".disabled=true
		$"../Stations/Stove/Area2D/CollisionShape2D".disabled=false
		$CanvasLayer/ColorRect/RichTextLabel.text="Now that we have all of our ingredients its time to start processing them! Select you rice using the number keys and then click when by one of the rice cookers to start cooking!"
		waitingFor="rice"

	elif(page==4):
		$CanvasLayer.visible=true
		$Sprite2D4.visible=false
		$Sprite2D5.visible=true
		$"../Stations/Stove/Area2D/CollisionShape2D".disabled=true
		$"../Stations/Cutting Board/Area2D/CollisionShape2D".disabled=false
		$CanvasLayer/ColorRect/RichTextLabel.text="Our rice is now cooking! That will take a minute to cook so while it's doing that lets slice up our fish! Head over here with fish selected and click to start cutting!"
		waitingFor="fish"
		
	elif(page==5):
		$CanvasLayer.visible=true
		$Sprite2D5.visible=false
		$"../Stations/Cutting Board/Area2D/CollisionShape2D".disabled=true
		$CanvasLayer/ColorRect/RichTextLabel.text="To cut the fish click with the mouse and drag the mouse around. Cut until the fish is sliced!"
		waitingFor="cutting"
		
	elif(page==6):
		$CanvasLayer.visible=true
		$"../Stations/Stove/Area2D/CollisionShape2D".disabled=false
		$"../Stations/Stove/Icon2/ProgressBar".value=100
		$Sprite2D4.visible=true
		$CanvasLayer/ColorRect/RichTextLabel.text="Now the fish is cut! Lets go get our rice as it is done cooking! Walk over to it and click to pick up the rice."
		waitingFor="cookedRice"
		
	elif(page==7):
		$CanvasLayer.visible=true
		$"../Stations/Stove/Area2D/CollisionShape2D".disabled=true
		$"../Stations/Assembly Board/Area2D/CollisionShape2D".disabled=false
		$Sprite2D4.visible=false
		$Sprite2D6.visible=true
		$CanvasLayer/ColorRect/RichTextLabel.text="Now we have everything we need to make some sushi! Head over to the assembly board with seaweed selected and click to start assembling!"
		waitingFor="assembly"
		
	elif(page==8):
		$CanvasLayer.visible=true
		$Sprite2D6.visible=false
		$"../Stations/Assembly Board/Area2D/CollisionShape2D".disabled=true
		$CanvasLayer/ColorRect/RichTextLabel.text="Now this is where the fun begins! Click on the cooked rice to add it to the sushi when it shows up!"
		waitingFor="onigiri"
		
	elif(page==9):
		$CanvasLayer.visible=true
		$CanvasLayer/ColorRect/RichTextLabel.text="Nice! Now that we have our rice placed lets put on our toppings! Click on the sliced fish and drag it onto the sushi! Then, click the big green button twice and you are done!"
		waitingFor="finishedAssembly"
	
	elif(page==10):
		$CanvasLayer.visible=true
		$"../Stations/Assembly Board/Area2D/CollisionShape2D".disabled=true
		$"../Stations/Desk/Area2D/CollisionShape2D".disabled=false
		$Sprite2D7.visible=true
		$CanvasLayer/ColorRect/RichTextLabel.text="We now have our sushi and its time to send it off to the customers! Walk over to the plate holder and click to pick up a plate! This is because we need something to serve the food on."
		waitingFor="plate"
		
	elif(page==11):
		$CanvasLayer.visible=true
		$"../Stations/Desk/Area2D/CollisionShape2D".disabled=true
		$"../Plate Roller/Rollers/Area2D/CollisionShape2D".disabled=false
		$Sprite2D7.visible=false
		$Sprite2D8.visible=true
		$CanvasLayer/ColorRect/RichTextLabel.text="Now with the plate selected click on the plate roller so you have a spot to put your sushi."
		waitingFor="placed"
	elif(page==12):
		$CanvasLayer.visible=true
		$Sprite2D8.visible=false
		$CanvasLayer/ColorRect/RichTextLabel.text="Now that the plate is placed select your sushi and click again to place it on the plate and ship it off!"
		waitingFor="shipped"
		
	elif(page==13):
		$CanvasLayer.visible=true
		$"../Plate Roller/Rollers/Area2D/CollisionShape2D".disabled=true
		$"../Area2D/CollisionShape2D".disabled=false
		$Sprite2D9.visible=true
		$CanvasLayer/ColorRect/RichTextLabel.text="Amazing! You just shipped your first order! When that meal comes back it will be dirty so lets learn how to clean dishes next! Walk over here to pick up the diry plate."
		waitingFor="dirtyPlate"
		$"../TV".speed=1500
		
	elif(page==14):
		$CanvasLayer.visible=true
		$"../Area2D/CollisionShape2D".disabled=true
		$"../Stations/Sink/Area2D/CollisionShape2D".disabled=false
		$Sprite2D9.visible=false
		$Sprite2D10.visible=true
		$CanvasLayer/ColorRect/RichTextLabel.text="Now that we have a dirty plate its time to clean it! Walk over here and click with the dirty plate selected to starts cleaning!"
		waitingFor="placedDirty"
		$"../TV".speed=200
		
	elif(page==15):
		$CanvasLayer.visible=true
		$Sprite2D10.visible=false
		$CanvasLayer/ColorRect/RichTextLabel.text="Now its time to clean the plate! Just click and wipe the sponge over the plate to remove any grime! When done it will sparkle because its very clean!"
		waitingFor="plate"
	elif(page==16):
		$CanvasLayer.visible=true
		$CanvasLayer/ColorRect/RichTextLabel.text="You can also order in items from the computer, but thats pretty self explanatory once you open it. The tutorial is now finished! Have fun playing!"
		waitingFor=""
		await get_tree().create_timer(5).timeout
		tutorial=false
		$"../Stations/Cucumber Reservoir/Area2D/CollisionShape2D".disabled=false
		$"../Stations/Cutting Board/Area2D/CollisionShape2D".disabled=false
		$"../Stations/Assembly Board/Area2D/CollisionShape2D".disabled=false
		$"../Stations/Stove/Area2D/CollisionShape2D".disabled=false
		$"../Stations/Stove2/Area2D/CollisionShape2D".disabled=false
		$"../Stations/Sink/Area2D/CollisionShape2D".disabled=false
		$"../Stations/Desk/Area2D/CollisionShape2D".disabled=false
		$"../Stations/Seaweed Reservoir/Area2D/CollisionShape2D".disabled=false
		$"../Stations/Fish Reservoir/Area2D/CollisionShape2D".disabled=false
		$"../Stations/Rice Reservoir/Area2D/CollisionShape2D".disabled=false
		$"../Plate Roller/Rollers/Area2D/CollisionShape2D".disabled=false
		$"../Area2D/CollisionShape2D".disabled=false



func _on_hide_pressed() -> void:
	$CanvasLayer.visible=false


func _on_quit_pressed() -> void:
	tutorial=false
	$"../Player".canMove=true
	$".".visible=false
	$CanvasLayer.visible=false
