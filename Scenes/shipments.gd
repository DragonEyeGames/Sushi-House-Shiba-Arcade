extends Node2D

var rising = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	shipment()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(rising):
		for child in $Control.get_children():
			child.position.y-=120*delta
	
func shipment():
	rising=true
