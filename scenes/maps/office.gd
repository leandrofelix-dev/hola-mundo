extends Node2D

var pause_menu: PackedScene = preload("res://scenes/ui/pause_menu.tscn")
var score_scene: PackedScene = preload("res://scenes/ui/score.tscn")
var score_ui: Control 


func _process(_delta: float):
	score_ui = score_scene.instantiate()
	add_child(score_ui)
	if Input.is_action_just_pressed("escape"):
		add_child(pause_menu.instantiate())
