extends Node2D

var fishEntered=false
var riceEntered=false
var cucumberEntered = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if($"cooked rice".visible==false):
		$"cooked rice/Area2D/CollisionPolygon2D".disabled=true
	else:
		$"cooked rice/Area2D/CollisionPolygon2D".disabled=false
	if($"sliced fish".visible==false):
		$"sliced fish/Area2D2/CollisionPolygon2D".disabled=true
	else:
		$"sliced fish/Area2D2/CollisionPolygon2D".disabled=false
	if($"sliced cucumber".visible==false):
		$"sliced cucumber/Area2D2/CollisionPolygon2D".disabled=true
	else:
		$"sliced cucumber/Area2D2/CollisionPolygon2D".disabled=false
	if(visible):
		if(riceEntered or fishEntered or cucumberEntered):
			self.material.set_shader_parameter("outline_size", GameManager.outlineSize)
		else:
			self.material.set_shader_parameter("outline_size", 0)
	else:
		self.material.set_shader_parameter("outline_size", 0)


func rice_entered() -> void:
	riceEntered=true


func rice_exited() -> void:
	riceEntered=false


func fish_entered() -> void:
	fishEntered=true


func fish_exited() -> void:
	fishEntered=false


func _fish_controller_entered(_area: Area2D) -> void:
	fishEntered=true


func _fish_controller_exited(_area: Area2D) -> void:
	fishEntered=false


func _rice_controller_entered(_area: Area2D) -> void:
	riceEntered=true


func rice_controller_exited(_area: Area2D) -> void:
	riceEntered=false


func rice_controller_entered(_area: Area2D) -> void:
	pass # Replace with function body.


func cucumber_entered(_area: Area2D) -> void:
	cucumberEntered=true


func cucumber_exited(_area: Area2D) -> void:
	cucumberEntered=false
