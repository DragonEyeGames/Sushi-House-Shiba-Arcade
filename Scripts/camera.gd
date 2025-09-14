extends Camera2D

var followingPlayer=true
var following

func _process(delta: float) -> void:
	if(followingPlayer):
		self.position=$"../Player".position
	else:
		self.position=following.position
		
func Zoom(amount: int):
	var tween = create_tween()
	tween.tween_property(self, "zoom", Vector2(amount, amount), 1.0)
