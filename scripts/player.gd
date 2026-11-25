extends CharacterBody2D

var gravity = 1500
var bounce_speed = 883
var steer_speed = 300

func _physics_process(delta):
	velocity.y += gravity * delta
	velocity.x = Input.get_axis("move_left", "move_right") * steer_speed
	move_and_slide()
	if is_on_floor():
		velocity.y = -bounce_speed
