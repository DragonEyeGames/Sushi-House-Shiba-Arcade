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


func _process(delta: float) -> void:
	# First, hide all order slots
	for i in range(4):
		var order_ui = get_node("Order %d" % (i + 1))
		order_ui.visible = false
		order_ui.get_node("ProgressBar").value = 100

	# Then, show active orders
	for i in range(orders.size()):
		if i >= 4:
			break  # Only handle first 4 orders if more exist

		var order = orders[i]
		var remaining = orderTimeRemaining[i]
		var order_ui = get_node("Order %d" % (i + 1))
		order_ui.visible = true
		order_ui.get_node("RichTextLabel").text = "1x " + str(order)
		
		var sushi_node = order_ui.get_node("Sushi")
		var onigiri_node = order_ui.get_node("Onigiri")
		sushi_node.visible = order == "sushi"
		onigiri_node.visible = order == "onigiri"

		# Update progress
		var progress = order_ui.get_node("ProgressBar")
		progress.value = remaining
		progress.value -= delta
		orderTimeRemaining[i] = progress.value

		# Remove expired orders
		if progress.value <= 0:
			orders.remove_at(i)
			orderTimeRemaining.remove_at(i)
			return  # Restart process to avoid index mismatch


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
