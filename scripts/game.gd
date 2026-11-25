extends Node2D

var platform_scene = preload("res://scenes/platform.tscn")
var ring_scene = preload("res://scenes/ring.tscn")
var top_y = 680
var last_x = 640
var min_gap = 80
var max_gap = 170
var max_step = 200
var extra_chance = 0.5
@onready var camera = $Camera2D
@onready var player = $player


func add_platform(x, y):
	var new_platform = platform_scene.instantiate()
	new_platform.position = Vector2(x, y)
	add_child(new_platform)
	
	
func make_platform():
	var new_y = top_y - randf_range(min_gap, max_gap)
	var left_limit = max(64, last_x - max_step)
	var right_limit = min(1216, last_x + max_step)
	var new_x = randf_range(left_limit, right_limit)
	add_platform(new_x, new_y)
	top_y = new_y
	last_x = new_x
	
	if randf() < extra_chance:
		var extra_x = randf_range(64, 1216)
		if abs(extra_x - new_x) > 250:
			add_platform(extra_x, new_y)
	
func make_ring():
	var new_ring = ring_scene.instantiate()
	new_ring.position = player.position
	add_child(new_ring)
	
func _process(_delta):
	while top_y > camera.position.y - 600:
		make_platform()
	
	
func _ready():
	player.landed.connect(make_ring)
