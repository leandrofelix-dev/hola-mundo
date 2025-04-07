extends Node2D

@onready var pause_menu: PackedScene = preload("res://scenes/ui/pause_menu.tscn")
@export var dialog_scene: PackedScene = load("res://scenes/ui/dialog.tscn")
@onready var form_maria_scene = preload("res://scenes/forms/form_maria.tscn")

var current_pause_menu: CanvasLayer = null
var dialog_instance: Control = null

func _ready():
	print("[OFFICE] Cena CARREGADA - Score atual:", Global.score)

	dialog_instance = dialog_scene.instantiate()
	$UI.add_child(dialog_instance)

	await dialog_instance.set_text("Dica: fale com os colegas de escritório para encontrar onde fica a sala de Recursos Humanos", 6.0)

	if has_node("ScoreUI"):
		$ScoreUI.update_score()

func _process(_delta):
	if Input.is_action_just_pressed("escape") and current_pause_menu == null:
		current_pause_menu = pause_menu.instantiate()
		add_child(current_pause_menu)
		current_pause_menu.tree_exited.connect(func(): current_pause_menu = null)

func iniciar_formulario_maria():
	var form_maria = form_maria_scene.instantiate()
	$UI.add_child(form_maria)

	form_maria.form_completed.connect(_on_formulario_maria_completo)

func _on_formulario_maria_completo(pontuacao, total):
	print("Formulário Maria finalizado. Pontuação: %d/%d" % [pontuacao, total])
