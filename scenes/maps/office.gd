extends Node2D

var pause_menu: PackedScene = preload("res://scenes/ui/pause_menu.tscn")

func _process(_delta: float):
	if Input.is_action_just_pressed("escape"):
		add_child(pause_menu.instantiate())
