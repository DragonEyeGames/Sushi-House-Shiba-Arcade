extends StaticBody2D

var copies = []
var orders = []
var orderTimeRemaining = []
var items = ["sushi", "sushi with cucumber", "onigiri", "onigiri with cucumber"]
var plateStack=0

func _ready() -> void:
	randomize()
	add_order()
	var original = $"../Sushi Rollers/Control/Path2D/PathFollow2D"
	for i in range(69):
		var copy = original.duplicate()
		$"../Sushi Rollers/Control/Path2D".add_child(copy)
		copy.progress=i*90
		copies.append(copy)
		copy.z_index=i
	original.visible = false
	orderCycle()


func _process(delta: float) -> void:
	for roller in $"../Sushi Rollers/Control/Path2D".get_children():
		roller.progress+=200*delta
		roller.z_index = int(roller.progress_ratio*100)
		if("Plate" in roller.get_child(0).name):
			if(roller.progress_ratio>=0.666):
				roller.progress_ratio=0.666
				roller.reparent($"../Sushi Rollers/Control")
				$"../Stations/PistonBase/AnimationPlayer".play("push")
				slide(roller)
	if(len(orders)==0):
		add_order()
	if($"../Tutorial".tutorial):
		return
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
		var _cucumber_sushi_node = order_ui.get_node("Cucumber Sushi")
		var _cucumber_onigiri_node = order_ui.get_node("Cucumber Onigiri")
		sushi_node.visible = order == "sushi"
		onigiri_node.visible = order == "onigiri"
		_cucumber_sushi_node.visible = order == "sushi with cucumber"
		_cucumber_onigiri_node.visible = order == "onigiri with cucumber"

		# Update progress
		var progress = order_ui.get_node("ProgressBar")
		progress.value = remaining
		progress.value -= delta
		orderTimeRemaining[i] = progress.value

		# Remove expired orders
		if progress.value <= 0:
			GameManager.score-=2
			if(GameManager.score<0):
				GameManager.score=0
			orders.remove_at(i)
			orderTimeRemaining.remove_at(i)
			for value in orderTimeRemaining:
				value*=.7
			return  # Restart process to avoid index mismatch


func _on_timer_timeout() -> void:
	for copy in copies:
		copy.z_index += 1


func orderCycle():
	await get_tree().create_timer(randi_range(25, 35)).timeout
	add_order()
	orderCycle()
	
func slide(plate):
	plateStack+=1
	plate.position.y-=plateStack*4
	for i in range(10):
		plate.position.x-=11.5
		await get_tree().create_timer(0).timeout
	plate.get_child(0).reparent($"../Stations/PlateHolder")
	plate.queue_free()


func add_order():
	if(not $"../Tutorial".tutorial):
		orders.append(items[randi() % items.size()])
		orderTimeRemaining.append(100)
