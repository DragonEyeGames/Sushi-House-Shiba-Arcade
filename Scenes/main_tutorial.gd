extends Node2D

@export var tutorial=true
var page = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if(tutorial):
		$"../Player".canMove=false
	else:
		visible=false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(Input.is_action_just_pressed("A")):
		_on_next_pressed()
	if(Input.is_action_just_pressed("B")):
		_on_quit_pressed()


func _on_next_pressed() -> void:
	page+=1
	if(page==1):
		$Arrow.visible=true
		$ColorRect/RichTextLabel.text="On this TV back here is your orders! This is where you will see what customers want made and how long you have to do it. If the bar reaches 0, you lose 500 points! If you fulfill the order, you gain 1000 points! Keeping an eye on this is important!"
	elif(page==2):
		$Arrow.visible=false
		$Arrow2.visible=true
		$ColorRect/RichTextLabel.text="Onto the ingredients! This is the rice bowl. It stores all of the rice you will need. To pick up some rice, walk up to it and click, press space, or press A on X-Box controller when prompted. You can't pick it up if you already have five items!"
	elif(page==3):
		$Arrow2.visible=false
		$Arrow3.visible=true
		$ColorRect/RichTextLabel.text="This is the fish freezer. If you ever need a fish, come over here and pick some up! All of the same picking up rules apply to this as the rice."
	elif(page==4):
		$Arrow3.visible=false
		$Arrow4.visible=true
		$ColorRect/RichTextLabel.text="And this over here is the seaweed sheet holder. Following the same rules as the other items for picking up, this is an essential item for making sushi. It is the base for all recipes. Stock up on this as you will need a lot of it!"
	elif(page==5):
		$Arrow4.visible=false
		$ColorRect/RichTextLabel.text="Onto cooking these ingredients! But before, an important note about how the inventory system works. When you pick up items from the reservoirs you can select them by pressing the number corresponding to it on key board or the left and right bumpers on X-Box controller to cycle through to reach it."
	elif(page==6):
		$Arrow5.visible=true
		$ColorRect/RichTextLabel.text="Now that we know how the inventory system works its time to start cooking! This over here is the rice cooker. Put any rice that you have into it and it will cook after some time! When it is done cooking, be sure to pick it up for later use! The same rules apply to picking things up from this as everything else."
	elif(page==7):
		$Arrow5.visible=false
		$Arrow6.visible=true
		$ColorRect/RichTextLabel.text="This is the cutting board. Place on your fish or anything else that needs cut. This will open up a minigame where you cut up the fish! Use the normal movement controls to move the knife and the normal selecting controls to cut! Then press the button or use the normal leaving controls (esc or X-Box B) to exit the minigame!"
	elif(page==8):
		$Arrow6.visible=false
		$Arrow7.visible=true
		$ColorRect/RichTextLabel.text="Time for assembly! When you have all of your ingredients prepared walk over here and select it to start working! You will select which rice to use and then you can drag all of your topping onto it! You can always remove something if you don't like it! Then press roll to roll up your sushi and pickup to take it with you!"
	elif(page==9):
		$Arrow7.visible=false
		$Arrow8.visible=true
		$ColorRect/RichTextLabel.text="Now that we have our food made its time to give it to the customers! Walk over here and select it to ship whatever item you have selected. Be warned: When you click its gone forever and if no one wanted it you lose 100 points! Be very careful before clicking here!"
	elif(page==10):
		$Arrow8.visible=false
		$Arrow9.visible=true
		$ColorRect/RichTextLabel.text="Last thing! If you ever pick up too many of something or accidentally obliterate your fish (it happens sometimes) you can throw it away here! Just click when selected and poof. Now that you are educated in all things sushi making its time to start! Click next or end to begin playing! (or A or B on X-Box)"
	elif(page==11):
		_on_quit_pressed()

func _on_quit_pressed() -> void:
	tutorial=false
	$".".visible=false
	$"../Player".canMove=true
