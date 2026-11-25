extends Camera2D

@export var player: Node2D
var best_y = 360
var fall_zone = 300
var max_drop = 250

func _process(_delta):
	if player.position.y < position.y:
		position.y = player.position.y
		best_y = position.y
	if player.position.y > position.y + fall_zone:
		position.y = player.position.y - fall_zone 
	position.y = min(position.y, best_y + max_drop)
