extends Node2D

var platform_scene = preload("res://scenes/platform.tscn")
var top_y = 680
var last_x = 640
var min_gap = 80
var max_gap = 170
var max_step = 200
@onready var camera = $Camera2D
