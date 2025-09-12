extends Sprite2D

var colliding = false

@export var item = ["seaweed", "onigiri", "sushi", "cooked rice", "fish"]

var seaweedPlaced = false
var ricePlaced = false
var fishPlaced = false

var currentItem = ""
var itemMatching = false
@export var controller: Node2D

func _ready() -> void:
	pass


func _process(delta: float) -> void:
	# Check if the player's selected item is one we accept
	itemMatching = controller.playerInventorySelect in item

	# Show prompts based on state
	if colliding:
		if controller.playerInventorySelect == "seaweed" and not seaweedPlaced and currentItem == "":
			_show_prompt("Place Seaweed")
		elif controller.playerInventorySelect == "cooked rice" and seaweedPlaced and not ricePlaced and currentItem == "seaweed":
			_show_prompt("Place Cooked Rice")
		elif controller.playerInventorySelect == "sliced fish" and ricePlaced and not fishPlaced and currentItem == "onigiri":
			_show_prompt("Place Sliced Fish")
		elif controller.playerInventorySelect == "onigiri" and currentItem == "":
			_show_prompt("Place Onigiri")
		elif controller.playerInventorySelect == "sushi" and currentItem == "":
			_show_prompt("Place Sushi")
		elif currentItem != "":
			if(len(controller.playerInventory) <= 4):
				_show_prompt("Pickup " + str(currentItem))
			else:
				self.material.set_shader_parameter("outline_size", 0)
		else:
			self.material.set_shader_parameter("outline_size", 0)
	else:
		self.material.set_shader_parameter("outline_size", 0)


func _show_prompt(text: String) -> void:
	self.material.set_shader_parameter("outline_size", 1.4)
	controller.interactable = "assembly board"
	controller.interactiveItem = self


func _on_area_2d_area_entered(area: Area2D) -> void:
	colliding = true


func _on_area_2d_area_exited(area: Area2D) -> void:
	self.material.set_shader_parameter("outline_size", 0)
	if(controller.interactiveItem==self):
		controller.interactable=""
		controller.interactiveItem=null
	colliding = false


func interact() -> void:
	if(not controller.interactiveItem==self):
		return
	# PLACE SEAWEED
	if controller.playerInventorySelect == "seaweed" and not seaweedPlaced:
		_consume_item("seaweed")
		$Seaweed.visible = true
		seaweedPlaced = true
		currentItem = "seaweed"

	# PLACE COOKED RICE
	elif controller.playerInventorySelect == "cooked rice" and seaweedPlaced and not ricePlaced:
		_consume_item("cooked rice")
		$Onigiri.visible = true
		$Seaweed.visible = false
		ricePlaced = true
		currentItem = "onigiri"

	# PLACE FISH
	elif controller.playerInventorySelect == "sliced fish" and ricePlaced and not fishPlaced:
		_consume_item("sliced fish")
		$Sushi.visible = true
		$Onigiri.visible = false
		fishPlaced = true
		currentItem = "sushi"
		
	# PLACE ONIGIRI
	elif controller.playerInventorySelect == "onigiri" and currentItem=="":
		_consume_item("onigiri")
		$Onigiri.visible = true
		seaweedPlaced=true
		ricePlaced = true
		currentItem = "onigiri"
		
	# PLACE SUSHI
	elif controller.playerInventorySelect == "sushi" and currentItem=="":
		_consume_item("sushi")
		$Sushi.visible = true
		seaweedPlaced=true
		ricePlaced = true
		fishPlaced=true
		currentItem = "sushi"
	
	elif colliding and currentItem != "" and len(controller.playerInventory) <= 4:
		controller.playerInventory.append(currentItem)
		$"../../Player/PickingUp".play()
		currentItem = ""
		_reset_visuals()


func _consume_item(item_name: String) -> void:
	controller.playerInventory.erase(item_name)
	controller.playerInventorySelect = ""
	for i in $"../../CanvasLayer".get_children():
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
