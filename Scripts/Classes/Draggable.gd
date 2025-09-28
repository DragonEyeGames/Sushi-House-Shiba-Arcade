extends Station

class_name Draggable

var dragging=false
var draggedItem
var dragOffset

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func drag() -> void:
	if(dragging):
		if(not controller.controller):
			draggedItem.global_position=get_global_mouse_position()+dragOffset
		else:
			draggedItem.global_position=$ControllerSelection.global_position+dragOffset
		if(not Input.is_action_pressed("Place")):
			dragging=false
