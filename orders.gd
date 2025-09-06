extends StaticBody2D

var copies = []
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var original = $"../SushiConveyer"
	for i in range(11):
		var copy = original.duplicate()  # deep copy if needed: duplicate(true)
		add_child(copy)
		copy.global_position = Vector2(original.global_position.x, original.global_position.y+(i*90))
		copy.z_index=10
		copies.append(copy)
	original.visible=false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if($"Order 1".visible):
		$"Order 1/ProgressBar".value-=1*delta
	if($"Order 2".visible):
		$"Order 2/ProgressBar".value-=1*delta
	if($"Order 3".visible):
		$"Order 3/ProgressBar".value-=1*delta
	if($"Order 4".visible):
		$"Order 4/ProgressBar".value-=1*delta


func _on_timer_timeout() -> void:
	for copy in copies:
		copy.z_index+=1
