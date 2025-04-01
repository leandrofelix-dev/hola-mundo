extends Node

var pause_menu: PackedScene = preload("res://scenes/ui/pause_menu.tscn")
var intro_scene: PackedScene = preload("res://scenes/intro.tscn")

func _ready():
	#var timer = get_tree().create_timer(1)
	get_tree().change_scene_to_file("res://scenes/intro.tscn")
	
	#await timer.timeout

	#get_tree().change_scene_to_file("res://scenes/characters/player.tscn")

func _process(_delta: float):
	if Input.is_action_just_pressed("escape"):
		add_child(pause_menu.instantiate())
