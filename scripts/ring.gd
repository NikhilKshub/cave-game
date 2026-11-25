extends Area2D

func _ready():
	scale = Vector2(0.05, 0.05)
	var grow_tween = create_tween()
	grow_tween.tween_property(self, "scale", Vector2.ONE, 0.5)
	grow_tween.tween_callback(queue_free)
	var fade_tween = create_tween()
	fade_tween.tween_property(self, "modulate:a", 0.0, 0.5)
