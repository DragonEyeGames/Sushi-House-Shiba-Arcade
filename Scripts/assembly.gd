extends Sprite2D

var colliding = false

@export var item = ["seaweed", "onigiri", "sushi", "cooked rice", "fish"]

var seaweedPlaced = false
var ricePlaced = false
var fishPlaced = false

var currentItem = ""
var itemMatching = false
var minigame=false
@export var controller: Node2D

func _ready() -> void:
	pass


func _process(delta: float) -> void:
	# Check if the player's selected item is one we accept
	itemMatching = controller.playerInventorySelect in item
	
	if(minigame and Input.is_action_just_pressed("Place")):
		if($Items.riceEntered or $Items2.riceEntered or $Items3.riceEntered or $Items4.riceEntered):
			$Rice.visible=true
	# Show prompts based on state
	if colliding:
		if controller.playerInventorySelect == "seaweed" and not seaweedPlaced and currentItem == "":
			_show_prompt("Place Seaweed")
		elif controller.playerInventorySelect == "cooked rice" and seaweedPlaced and not ricePlaced and currentItem == "seaweed":
			_show_prompt("Place Cooked Rice")
		elif controller.playerInventorySelect == "sliced fish" and ricePlaced and not fishPlaced and currentItem == "onigiri":
			_show_prompt("Place Sliced Fish")
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
	if(minigame==true):
		return
	_consume_item("seaweed")
	var showList=[]
	for item in controller.playerInventory:
		if(item=="cooked rice"):
			showList.append(item)
	if len(showList)>=1:
		$Items.visible=true
		$Items.global_position=$"../../Player".global_position
		var tween = create_tween()
		tween.tween_property($Items, "position", Vector2(-123, -99), 1) # move to (400, 300) in 0.5s
		for i in $Items.get_children():
			i.visible=false
		if $Items.get_node_or_null(showList[0]) !=null:
			$Items.get_node_or_null(showList[0]).visible=true
	else:
		$Items.visible=false
	if len(showList)>=2:
		$Items2.global_position=$"../../Player".global_position
		$Items2.visible=true
		var tween = create_tween()
		tween.tween_property($Items2, "position", Vector2(99, -104), 1) # move to (400, 300) in 0.5s
		for i in $Items2.get_children():
			i.visible=false
		if $Items2.get_node_or_null(showList[1]) !=null:
			$Items2.get_node_or_null(showList[1]).visible=true
	else:
		$Items2.visible=false
	if len(showList)>=3:
		$Items3.global_position=$"../../Player".global_position
		$Items3.visible=true
		var tween = create_tween()
		tween.tween_property($Items3, "position", Vector2(-126, -38), 1) # move to (400, 300) in 0.5s
		for i in $Items3.get_children():
			i.visible=false
		if $Items3.get_node_or_null(showList[2]) !=null:
			$Items3.get_node_or_null(showList[2]).visible=true
	else:
		$Items3.visible=false
	if len(showList)>=4:
		$Items4.global_position=$"../../Player".global_position
		$Items4.visible=true
		var tween = create_tween()
		tween.tween_property($Items4, "position", Vector2(108, -42), 1) # move to (400, 300) in 0.5s
		for i in $Items4.get_children():
			i.visible=false
		if $Items4.get_node_or_null(showList[3]) !=null:
			$Items4.get_node_or_null(showList[3]).visible=true
	else:
		$Items4.visible=false
	$"../../Camera2D".following=self
	$"../../Camera2D".followingPlayer=false
	$"../../Camera2D".Zoom(5)
	$Seaweed.visible=true
	self.material.set_shader_parameter("outline_size", 0)
	$"../../Player".canMove=false
	# Animate the alpha of the modulate color
	$"../../MinigameLayer".visible=true
	for child in $"../../CanvasLayer".get_children():
		var t = create_tween()
		t.tween_property(child, "modulate:a", 0.0, 1.0)
	var t = create_tween()
	t.tween_property($"../../MinigameLayer/Button", "modulate:a", 1.0, 1.0)
	minigame=true


func _consume_item(item_name: String) -> void:
	controller.placeCurrent()


func _reset_visuals() -> void:
	$Seaweed.visible = false
	$Onigiri.visible = false
	$Sushi.visible = false
	seaweedPlaced = false
	ricePlaced = false
	fishPlaced = false
