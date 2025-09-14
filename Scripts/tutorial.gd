extends Node2D

var playerInventorySelect=""
var interactable=""
var interactiveItem
var playerInventory=[]
var currentSpeech=0
var riceColliding=false
var stoveColliding=false
var seaweedColliding=false
var fishColliding=false
var cuttingColliding=false
var minigameOpening=false
var assemblyColliding=false
var rollerColliding=false
var score=0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$"Plate Roller/Rollers/Area2D/CollisionShape2D".disabled=true
	$Stove/Area2D/CollisionShape2D.disabled=true
	$"Rice Reservoir/Area2D/CollisionShape2D".disabled=true
	$"Fish Reservoir/Area2D/CollisionShape2D".disabled=true
	$"Seaweed Reservoir/Area2D/CollisionShape2D".disabled=true
	$Trash/Area2D/CollisionShape2D.disabled=true
	$"Cutting Board/Area2D/CollisionShape2D".disabled=true
	$"Assembly Board/Area2D/CollisionShape2D".disabled=true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	print(playerInventorySelect)
	if(riceColliding and Input.is_action_just_pressed("Place")):
		$"Rice Reservoir/Area2D/CollisionShape2D".disabled=true
		riceColliding=false
		_on_next_pressed()
	if(stoveColliding and Input.is_action_just_pressed("Place")):
		$Stove/Area2D/CollisionShape2D.disabled=true
		stoveColliding=false
		_on_next_pressed()
	if(seaweedColliding and Input.is_action_just_pressed("Place")):
		$Stove/Area2D/CollisionShape2D.disabled=true
		seaweedColliding=false
		_on_next_pressed()
	if(fishColliding and Input.is_action_just_pressed("Place")):
		$Stove/Area2D/CollisionShape2D.disabled=true
		fishColliding=false
		_on_next_pressed()
	if(rollerColliding and Input.is_action_just_pressed("Place")):
		rollerColliding=false
		_on_next_pressed()
	if(cuttingColliding and Input.is_action_just_pressed("Place") and not minigameOpening):
		_on_next_pressed()
	elif(cuttingColliding and Input.is_action_just_pressed("Place") and minigameOpening):
		_on_next_pressed()
	elif(assemblyColliding and Input.is_action_just_pressed("Place")):
		_on_next_pressed()
		
	for i in range($CanvasLayer.get_child_count()):
		var child = $CanvasLayer.get_child(i)
		if i >= playerInventory.size():
			if(child.name!="Outline"):
				child.visible=false
		else:
			child.visible=true
	#Visibility mod
	for i in range($CanvasLayer.get_child_count()):
		var slot = $CanvasLayer.get_child(i).get_child(2)

		# Hide everything in this slot first
		for child in slot.get_children():
			child.visible = false

		# Show the player's inventory item if it exists for this slot
		if i < playerInventory.size():
			var item_name = playerInventory[i]
			var item_node = slot.get_node_or_null(item_name)
			if item_node:
				item_node.visible = true
	if(Input.is_action_just_pressed("Place") and interactable!=""):
		interactiveItem.interact()


func _on_quit_pressed() -> void:
	get_tree().change_scene_to_file("res://main.tscn")


func _on_next_pressed() -> void:
	currentSpeech+=1
	if(currentSpeech==1):
		$Arrow.visible=true
		$Tutorial/ColorRect2/RichTextLabel.text="This TV back here will display all of your orders and how much time is left on them! These will come in periodically and you will try your best to fulfill them!"
	elif(currentSpeech==2):
		$"TV/Order 1".visible=true
		$Tutorial/ColorRect2/RichTextLabel.text="On this TV is the orders. They tell you what is wanted and how much time is left in the order. Normally that will count down but not for this tutorial."
	if(currentSpeech==3):
		$Arrow.visible=false
		$Arrow2.visible=true
		$Tutorial/Next.visible=false
		$"Rice Reservoir/Area2D/CollisionShape2D".disabled=false
		$Tutorial/ColorRect2/RichTextLabel.text="Something Needed in every dish is rice. Pick up some by walking over here and clicking or pressing space when prompted."
	if(currentSpeech==4):
		$Arrow2.visible=false
		$Arrow3.visible=true
		$"Rice Reservoir/Area2D/CollisionShape2D".disabled=true
		$Stove/Area2D/CollisionShape2D.disabled=false
		playerInventorySelect="rice"
		$Tutorial/ColorRect2/RichTextLabel.text="Now that we have rice we need to cook it! Walk over to the rice cooker and click again to start cooking the rice."
	if(currentSpeech==5):
		$Arrow3.visible=false
		$Stove/Area2D/CollisionShape2D.disabled=true
		$Arrow4.visible=true
		$"Seaweed Reservoir/Area2D/CollisionShape2D".disabled=false
		$Tutorial/ColorRect2/RichTextLabel.text="That will take a minute to cook. While its doing that lets grab some seaweed from over here. This will be the base for all items."
	if(currentSpeech==6):
		$Arrow4.visible=false
		$"Seaweed Reservoir/Area2D/CollisionShape2D".disabled=true
		$Arrow5.visible=true
		$"Fish Reservoir/Area2D/CollisionShape2D".disabled=false
		$Tutorial/ColorRect2/RichTextLabel.text="While we are still over here lets go ahead and grab some fish. This will be used in the next step as well."
	if(currentSpeech==7):
		$Arrow5.visible=false
		$"Fish Reservoir/Area2D/CollisionShape2D".disabled=true
		$Arrow6.visible=true
		$"Cutting Board/Area2D/CollisionShape2D".disabled=false
		playerInventorySelect="fish"
		$Tutorial/ColorRect2/RichTextLabel.text="Lets go ahead and cut up this fish. Walk over to the cutting board and click or press space to place the fish."
	if(currentSpeech==8):
		minigameOpening=true
		$Tutorial/ColorRect2/RichTextLabel.text="Now go ahead and click again to open up the cutting minigame!"
	if(currentSpeech==9):
		$Arrow6.visible=false
		$"Cutting Board/Area2D/CollisionShape2D".disabled=true
		$Tutorial/ColorRect2/RichTextLabel.text="Now that we have the minigame open you click with the mouse to start cutting! Drag the mouse and the knife to cut up the fish!"
	if(currentSpeech==10):
		$MinigameLayer/Button.visible=true
		$Tutorial/ColorRect2/RichTextLabel.text="Now our fish is cut! Be careful to not overcut it as it will be wasted! Click on the leave button in top left to exit this screen."
	if(currentSpeech==11):
		$"Cutting Board/Area2D/CollisionShape2D".disabled=false
		$Tutorial/ColorRect2/RichTextLabel.text="Now click once more to pick up our fish."
	if(currentSpeech==12):
		$Arrow3.visible=true
		$Stove/Area2D/CollisionShape2D.disabled=false
		$Stove/Icon2/ProgressBar.value=100
		playerInventorySelect="seaweed"
		$Tutorial/ColorRect2/RichTextLabel.text="Nice! Now lets head over and get our rice as it is done cooking!"
	if(currentSpeech==13):
		$Arrow3.visible=false
		$Stove/Area2D/CollisionShape2D.disabled=true
		$Arrow7.visible=true
		$"Assembly Board/Area2D/CollisionShape2D".disabled=false
		playerInventorySelect="seaweed"
		$Tutorial/ColorRect2/RichTextLabel.text="Now that we have everything its time to assemble it! Go to the assembly mat and click to place your seaweed."
		await get_tree().create_timer(.1).timeout
		playerInventorySelect="seaweed"
	if(currentSpeech==14):
		$Tutorial/ColorRect2/RichTextLabel.text="Now click again to place your cooked rice."
		await get_tree().create_timer(.001).timeout
		playerInventorySelect="cooked rice"
	if(currentSpeech==15):
		$Tutorial/ColorRect2/RichTextLabel.text="And once more for your sliced fish."
		await get_tree().create_timer(.001).timeout
		playerInventorySelect="sliced fish"
	if(currentSpeech==16):
		$Tutorial/ColorRect2/RichTextLabel.text="Now pick up the sushi and lets continue!"
	if(currentSpeech==17):
		$Arrow7.visible=false
		$"Assembly Board/Area2D/CollisionShape2D".disabled=true
		$Arrow8.visible=true
		$"Plate Roller/Rollers/Area2D/CollisionShape2D".disabled=false
		$Tutorial/ColorRect2/RichTextLabel.text="Now for the final step! Walk over here and click to deliver your food!"
		await get_tree().create_timer(.1).timeout
		playerInventorySelect="sushi"
	if(currentSpeech==18):
		$Arrow8.visible=false
		$"Plate Roller/Rollers/Area2D/CollisionShape2D".disabled=true
		$"TV/Order 1".visible=false
		$Tutorial/ColorRect2/RichTextLabel.text="Congrats you delivered your first order! A few things before you move on to the main game. The orders will count down and you lose score if it reaches 0. You also need to select inventory items by pressing the number keys that correlate to them before using them. You are now ready to start the game!"
		$Tutorial/ColorRect2/RichTextLabel.add_theme_font_size_override("normal_font_size", 30)
		$Tutorial/Next.visible=true
	if(currentSpeech==19):
		get_tree().change_scene_to_file("res://main.tscn")
	
		


func _on_area_2d_area_entered(area: Area2D) -> void:
	riceColliding=true


func _on_area_2d_area_exited(area: Area2D) -> void:
	riceColliding=false


func _on_stove(area: Area2D) -> void:
	stoveColliding=true


func _on_stove_out(area: Area2D) -> void:
	stoveColliding=false


func _on_seaweed(area: Area2D) -> void:
	seaweedColliding=true


func _on_seaweed_exit(area: Area2D) -> void:
	seaweedColliding=false


func _fish_entered(area: Area2D) -> void:
	fishColliding=true


func _fish_exited(area: Area2D) -> void:
	fishColliding=false


func _cutting_entered(area: Area2D) -> void:
	cuttingColliding=true


func cutting_exited(area: Area2D) -> void:
	cuttingColliding=false
	
func sliced():
	_on_next_pressed()


func _on_button_pressed() -> void:
	_on_next_pressed()


func _on_assembly_entered(area: Area2D) -> void:
	assemblyColliding=true


func _assembly_leaving(area: Area2D) -> void:
	assemblyColliding=false


func _on_roller_entered(area: Area2D) -> void:
	rollerColliding=true


func _on_roller_exited(area: Area2D) -> void:
	rollerColliding=false
