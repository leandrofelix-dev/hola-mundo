extends Node2D

@onready var pause_menu: PackedScene = preload("res://scenes/ui/pause_menu.tscn")
var current_pause_menu: Control = null

func _ready():
	print("[OFFICE] Cena CARREGADA - Score atual:", Global.score)
	# Força atualização se necessário
	if has_node("ScoreUI"):
		$ScoreUI.update_score()

func _process(_delta):
	if Input.is_action_just_pressed("escape") and current_pause_menu == null:
		current_pause_menu = pause_menu.instantiate()
		add_child(current_pause_menu)
		current_pause_menu.tree_exited.connect(func(): current_pause_menu = null)
