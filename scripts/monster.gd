extends Area2D
signal caught

var speed = 40
func _physics_process(delta: float) -> void:
	position.y -= speed * delta 


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		caught.emit()
