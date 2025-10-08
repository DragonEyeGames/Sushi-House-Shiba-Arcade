extends Sprite2D

var img : Image
var tex : ImageTexture
var sprite

func remove_circle(p1: Vector2, p2: Vector2, radius: float):
	var min_x = int(min(p1.x, p2.x) - radius)
	var max_x = int(max(p1.x, p2.x) + radius)
	var min_y = int(min(p1.y, p2.y) - radius)
	var max_y = int(max(p1.y, p2.y) + radius)

	var r2 = radius * radius
	var axis = (p2 - p1).normalized()

	for x in range(min_x, max_x):
		for y in range(min_y, max_y):
			var p = Vector2(x, y)
			var t = clamp((p - p1).dot(axis), 0.0, p1.distance_to(p2))
			var closest = p1 + axis * t
			if p.distance_squared_to(closest) <= r2 and x>=0 and x<256 and y>=0 and y<256:
				img.set_pixel(x, y, Color(0, 0, 0, 0))
	if(img.get_used_rect().size == Vector2i.ZERO or (img.get_used_rect().size.x*img.get_used_rect().size.y<=200)):
		sprite.queue_free()
		get_parent().get_child(1).cleaned=true
		$Sparkle.emitting=true
		$AudioStreamPlayer2D2.play()
		await get_tree().create_timer(.9).timeout
		$Sparkle.emitting=false
		await get_tree().create_timer(1).timeout
		get_parent()._on_button_pressed()
		self.visible=false
	else:
		print(img.get_used_rect().size)
	tex.update(img)
	
func newDirt():
	sprite=$PlateDirt.duplicate()
	sprite.visible=true
	add_child(sprite)
	img = sprite.texture.get_image()
	tex = ImageTexture.create_from_image(img)
	sprite.texture = tex
