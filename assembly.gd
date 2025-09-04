extends StaticBody2D

var colliding = false

@export var item = ["seaweed", "onigiri", "sushi", "cooked rice", "fish"]

var seaweedPlaced = false
var ricePlaced = false
var fishPlaced = false

var currentItem = ""
var itemMatching = false

func _ready() -> void:
	pass


func _process(delta: float) -> void:
	# Check if the player's selected item is one we accept
	itemMatching = $"..".playerInventorySelect in item

	# Show prompts based on state
	if colliding:
		if $"..".playerInventorySelect == "seaweed" and not seaweedPlaced and currentItem == "":
			_show_prompt("Place Seaweed")
		elif $"..".playerInventorySelect == "cooked rice" and seaweedPlaced and not ricePlaced and currentItem == "seaweed":
			_show_prompt("Place Cooked Rice")
		elif $"..".playerInventorySelect == "fish" and ricePlaced and not fishPlaced and currentItem == "onigiri":
			_show_prompt("Place Salmon")
		elif $"..".playerInventorySelect == "onigiri" and currentItem == "":
			_show_prompt("Place Onigiri")
		elif $"..".playerInventorySelect == "sushi" and currentItem == "":
			_show_prompt("Place Sushi")
		elif currentItem != "":
			if(len($"..".playerInventory) <= 4):
				_show_prompt("Pickup " + str(currentItem))
			else:
				$RichTextLabel.visible = false
		else:
			$RichTextLabel.visible = false
	else:
		$RichTextLabel.visible = false


func _show_prompt(text: String) -> void:
	$RichTextLabel.visible = true
	$RichTextLabel.text = text
	$"..".interactable = "assembly board"
	$"..".interactiveItem = self


func _on_area_2d_area_entered(area: Area2D) -> void:
	colliding = true


func _on_area_2d_area_exited(area: Area2D) -> void:
	if colliding and itemMatching:
		$RichTextLabel.visible = false
		$"..".interactable = ""
		$"..".interactiveItem = null
	colliding = false


func interact() -> void:

	# PLACE SEAWEED
	if $"..".playerInventorySelect == "seaweed" and not seaweedPlaced:
		_consume_item("seaweed")
		$Seaweed.visible = true
		seaweedPlaced = true
		currentItem = "seaweed"

	# PLACE COOKED RICE
	elif $"..".playerInventorySelect == "cooked rice" and seaweedPlaced and not ricePlaced:
		_consume_item("cooked rice")
		$Onigiri.visible = true
		$Seaweed.visible = false
		ricePlaced = true
		currentItem = "onigiri"

	# PLACE FISH
	elif $"..".playerInventorySelect == "fish" and ricePlaced and not fishPlaced:
		_consume_item("fish")
		$Sushi.visible = true
		$Onigiri.visible = false
		fishPlaced = true
		currentItem = "sushi"
		
	# PLACE ONIGIRI
	elif $"..".playerInventorySelect == "onigiri" and currentItem=="":
		_consume_item("onigiri")
		$Onigiri.visible = true
		seaweedPlaced=true
		ricePlaced = true
		currentItem = "onigiri"
		
	# PLACE SUSHI
	elif $"..".playerInventorySelect == "sushi" and currentItem=="":
		_consume_item("sushi")
		$Sushi.visible = true
		seaweedPlaced=true
		ricePlaced = true
		fishPlaced=true
		currentItem = "sushi"
	
	elif colliding and currentItem != "" and len($"..".playerInventory) <= 4:
		$"..".playerInventory.append(currentItem)
		currentItem = ""
		_reset_visuals()


func _consume_item(item_name: String) -> void:
	$"..".playerInventory.erase(item_name)
	$"..".playerInventorySelect = ""
	for i in $"../CanvasLayer".get_children():
		var outline = i.get_node_or_null("Outline")
		if outline:
			outline.visible = false


func _reset_visuals() -> void:
	$Seaweed.visible = false
	$Onigiri.visible = false
	$Sushi.visible = false
	seaweedPlaced = false
	ricePlaced = false
	fishPlaced = false
