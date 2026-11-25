extends StaticBody2D


@onready var lit = $lit
var tween

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free() 

func light_up():
	if tween:
		tween.kill()
	lit.modulate.a = 1
	tween = create_tween()
	tween.tween_property(lit, "modulate:a", 0.0, 1.5)
