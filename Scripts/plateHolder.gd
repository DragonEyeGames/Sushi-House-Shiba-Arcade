extends Node2D

var colliding=false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if(len(get_children())>0):
		if(colliding and len($"../..".playerInventory)<=4):
			for child in get_children():
				child.material.set_shader_parameter("outline_size", 0.0)
			get_child(-1).material.set_shader_parameter("outline_size", GameManager.outlineSize)
			if(Input.is_action_just_pressed("Place")):
				get_child(-1).queue_free()
				$"../..".playerInventory.append("dirty plate")
		else:
			get_child(-1).material.set_shader_parameter("outline_size", 0.0)


func _on_area_2d_area_entered(_area: Area2D) -> void:
	colliding=true


func _on_area_2d_area_exited(_area: Area2D) -> void:
	colliding=false
