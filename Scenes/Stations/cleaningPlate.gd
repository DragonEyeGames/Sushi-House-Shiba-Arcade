extends Sprite2D

var img : Image
var tex : ImageTexture

func _ready():
	# Get an editable copy of the sprite’s PNG
	img = $PlateDirt.texture.get_image()
	tex = ImageTexture.create_from_image(img)
	$PlateDirt.texture = tex

func remove_circle(center: Vector2, radius: int):
	var r2 = radius * radius
	for x in range(center.x - radius, center.x + radius):
		for y in range(center.y - radius, center.y + radius):
			var dx = x - center.x
			var dy = y - center.y
			if dx * dx + dy * dy <= r2 and (x >= 0 and x < 256) and (y >= 0 and y < 256):
				img.set_pixel(x, y, Color(0,0,0,0)) # fully transparent
	tex.update(img)
