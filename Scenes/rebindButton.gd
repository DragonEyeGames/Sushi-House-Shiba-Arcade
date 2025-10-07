extends Control

@export var textToShow :=""
@export var actionToRebind := ""
var waitingForInput := false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	$RichTextLabel.text=textToShow
	if(not waitingForInput):
		$Button.text=InputMap.action_get_events(actionToRebind)[0].as_text()
	else:
		$Button.text="Waiting for input..."

func start_rebind():
	waitingForInput = true
	print("Press a key to rebind", actionToRebind)

func _input(event):
	if(not waitingForInput):
		return
	if waitingForInput and event is InputEventKey and event.pressed:
		accept_event()
		rebind_action(actionToRebind, event)
		waitingForInput = false
	elif event is InputEventMouseButton and event.pressed:
		if event.double_click:
			return 
		accept_event()
		rebind_action(actionToRebind, event)
		waitingForInput = false

func rebind_action(action_name: String, event):
	InputMap.action_erase_events(action_name)
	InputMap.action_add_event(action_name, event)
	print("Rebound", action_name, "to", event.as_text())
	waitingForInput=false
