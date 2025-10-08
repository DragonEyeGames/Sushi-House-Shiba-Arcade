extends Node2D

var mouseEntered=false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _on_area_2d_mouse_entered() -> void:
	var visibleChild := false
	for child in get_children():
		if(child.visible and not child.name=="Area2D"):
			visibleChild=true
	if(visibleChild):
		mouseEntered=true


func _on_area_2d_mouse_exited() -> void:
	mouseEntered=false
