extends Camera2D

var followingPlayer=true
var following

func _process(_delta: float) -> void:
	if(followingPlayer):
		self.global_position=$"../Player".global_position
	else:
		self.global_position=following.global_position
		
func Zoom(amount: int):
	var tween = create_tween()
	tween.tween_property(self, "zoom", Vector2(amount, amount), 1.0)
