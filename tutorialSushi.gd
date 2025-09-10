extends StaticBody2D

var copies = []
var orders = []
var orderTimeRemaining = []
var items = ["sushi", "onigiri"]

func _ready() -> void:
	randomize()
	add_order()
	var original = $"../Sushi Rollers/SushiConveyer"
	for i in range(11):
		var copy = original.duplicate()
		$"../Sushi Rollers".add_child(copy)
		copy.global_position = Vector2(original.global_position.x, original.global_position.y + (i * 90))
		copy.z_index = 10
		copies.append(copy)
	original.visible = false
	orderCycle()


func _on_timer_timeout() -> void:
	for copy in copies:
		copy.z_index += 1


func orderCycle():
	await get_tree().create_timer(randi_range(25, 35)).timeout
	add_order()
	orderCycle()


func add_order():
	orders.append(items[randi() % items.size()])
	orderTimeRemaining.append(100)
