extends Node2D

var platform_scene = preload("res://scenes/platform.tscn")
var top_y = 680
var last_x = 640
var min_gap = 80
var max_gap = 170
var max_step = 200
@onready var camera = $Camera2D

func make_platform():
	var new_platform = platform_scene.instantiate()
	var new_y = top_y - randf_range(min_gap, max_gap)
	var new_x = last_x + randf_range(-max_step, max_step)
	new_x = clampf(new_x, 64, 1216)
	new_platform.position = Vector2(new_x, new_y)
	add_child(new_platform)
	top_y = new_y
	last_x = new_x
	
func _process(delta):
	while top_y > camera.position.y - 600:
		make_platform()
	
