extends Node2D

var platform_scene = preload("res://scenes/platform.tscn")
var ring_scene = preload("res://scenes/ring.tscn")
var top_y = 680
var last_x = 640
var min_gap = 80
var max_gap = 170
var max_step = 200
var extra_chance = 0.5
var scale_steps = [0, 2, 4, 7, 9]

@onready var note_player = $note_player
@onready var camera = $Camera2D
@onready var player = $player
@onready var monster = $monster

var hearts = 3
var safe = false


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
	if Input.is_action_just_pressed("restart"):
		get_tree().reload_current_scene()
	
func play_note():
	var height = 680 - player.position.y
	var index = int(height / 100) % 10
	var degree = index % 5
	var octave = int(index / 5.0)
	var semitones = scale_steps[degree] + 12 * octave
	note_player.pitch_scale = pow(2, semitones / 12.0)
	note_player.play()

func _ready():
	player.landed.connect(make_ring)
	player.landed.connect(play_note)
	monster.caught.connect(on_caught)
	
	
func on_caught():
	if safe:
		return 
	hearts -=1
	print("hearts", hearts)
	if hearts <= 0:
		get_tree().reload_current_scene()
		return
	player.rescue_bounce()
	monster.position.y += 400
	safe = true
	get_tree().create_timer(2.0).timeout.connect(end_safe)
	
func end_safe():
	safe = false

	
	
