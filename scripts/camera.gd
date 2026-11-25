extends Camera2D

@export var player: Node2D
func _process(_delta):
	if player.position.y < position.y:
		position.y = player.position.y
