extends Node2D

var fishEntered=false
var riceEntered=false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(visible):
		if(riceEntered or fishEntered):
			self.material.set_shader_parameter("outline_size", 1.4)
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
