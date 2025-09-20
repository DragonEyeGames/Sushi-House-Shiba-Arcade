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
func _process(_delta: float) -> void:
	if(Input.is_action_just_pressed("A")):
		_on_next_pressed()
	if(Input.is_action_just_pressed("B")):
		_on_quit_pressed()
func _on_next_pressed() -> void:
	page+=1
	if(page==1):
		$Arrow.visible=true
		$ColorRect/RichTextLabel.text="This back here is the TV. It displays orders. You want to keep an eye on this so you know what to make! If the time runs out you lose the order and money!"
	elif(page==2):
		$Arrow.visible=false
		$Arrow2.visible=true
		$ColorRect/RichTextLabel.text="This over here is the rice bowl. It is used in every single dish in the game! As you need to cook this you should put some rice into the pot whenever you can."
	elif(page==3):
		$Arrow2.visible=false
		$Arrow3.visible=true
		$ColorRect/RichTextLabel.text="This is the fish freezer! Any fish that you get from here needs to be sliced before it can be consumed."
	elif(page==4):
		$Arrow3.visible=false
		$Arrow4.visible=true
		$ColorRect/RichTextLabel.text="This over here is the seaweed sheet holder. Seaweed is also used in every dish so you should hold a few of these at all times!"
	elif(page==5):
		$Arrow4.visible=false
		$Arrow10.visible=true
		$ColorRect/RichTextLabel.text="This over here is cucumber! It is used just like fish but is a vegetable!"
	elif(page==6):
		$Arrow10.visible=false
		$ColorRect/RichTextLabel.text="Quick intermission over the inventory! There will always be an item selected (unless you don't have any) and you can change which one is selected with the number keys."
	elif(page==7):
		$Arrow5.visible=true
		$ColorRect/RichTextLabel.text="This is the rice cooker! As it takes time it is recommended to always put rice in it when possible."
	elif(page==8):
		$Arrow5.visible=false
		$Arrow6.visible=true
		$ColorRect/RichTextLabel.text="This is the cutting board! It is used to cut up fish and cucumbers before they are put in sushi!"
	elif(page==9):
		$Arrow6.visible=false
		$Arrow7.visible=true
		$ColorRect/RichTextLabel.text="This is where you assemble everything! Just click the rice you want and drag on any toppings before pressing roll!"
	elif(page==10):
		$Arrow7.visible=false
		$Arrow8.visible=true
		$ColorRect/RichTextLabel.text="This is where you ship your finished items! Bring it over here and click with it selected to send it off! Just make sure its something people want!"
	elif(page==11):
		$Arrow8.visible=false
		$Arrow9.visible=true
		$ColorRect/RichTextLabel.text="You can also throw anything you don't want away over here! Just don't throw away something useful!"
	elif(page==12):
		$Arrow9.visible=false
		$Arrow11.visible=true
		$ColorRect/RichTextLabel.text="This over here is the computer! This is where you order in your ingredients! Just make sure to order them in advance because they take a bit to show up!"
	elif(page==13):
		$Arrow11.visible=false
		$Arrow12.visible=true
		$ColorRect/RichTextLabel.text="This is where you pick up your orders! Pick up the box and deposit it in the reservoirs to get the goods inside! And with that you are ready to start! Click end tutorial to play the game!"
	elif(page==14):
		_on_quit_pressed()

func _on_quit_pressed() -> void:
	tutorial=false
	$".".visible=false
	$"../Player".canMove=true
