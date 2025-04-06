extends Node2D

@onready var anim = $AnimatedSprite2D
@onready var area: Area2D = $Area2D

var dialog_instance: Control = null
var form_instance: Node2D = null

@export var dialog_scene: PackedScene = preload("res://scenes/ui/dialog.tscn")
@export var form_scene: PackedScene = preload("res://scenes/tasks/audio_typing.tscn")

func _ready():
	if area:
		area.body_entered.connect(_on_body_entered)
	else:
		print("Area2D não foi encontrada!")

func _physics_process(_delta):
	anim.play("idle")

func _on_body_entered(body):
	if body is CharacterBody2D and dialog_instance == null:
		var ui_layer = get_tree().current_scene.get_node("UI")
		if not ui_layer:
			print("UI layer não encontrado!")
			return

		# Diálogo 1
		dialog_instance = dialog_scene.instantiate()
		ui_layer.add_child(dialog_instance)
		await dialog_instance.set_text("Pedro: ¡Hola! Soy Pedro, María me pidió que viniera a hablar contigo.", 8.0)
		dialog_instance.queue_free()
		dialog_instance = null

		# Diálogo 2
		dialog_instance = dialog_scene.instantiate()
		ui_layer.add_child(dialog_instance)
		await dialog_instance.set_text("Jessika: ¡Hola Pedro! Sentir la libertad", 5.0)
		dialog_instance.queue_free()
		dialog_instance = null

		# Diálogo 3
		dialog_instance = dialog_scene.instantiate()
		ui_layer.add_child(dialog_instance)
		await dialog_instance.set_text("Jessika: Aquí tendrás que tener un oído entrenado para entender al resto del equipo.", 10.0)
		dialog_instance.queue_free()
		dialog_instance = null

		# Diálogo 4
		dialog_instance = dialog_scene.instantiate()
		ui_layer.add_child(dialog_instance)
		await dialog_instance.set_text("Jessika: Aquí sobre la mesa hay una radio con algunos audios en español que son muy comunes en nuestra vida diaria.", 10.0)
		dialog_instance.queue_free()
		dialog_instance = null

		# Diálogo 5
		dialog_instance = dialog_scene.instantiate()
		ui_layer.add_child(dialog_instance)
		await dialog_instance.set_text("Jessika: practica un poco", 4.0)
		dialog_instance.queue_free()
		dialog_instance = null

		# Formulário
		form_instance = form_scene.instantiate()
		ui_layer.add_child(form_instance)

		if form_instance.has_signal("form_completed"):
			form_instance.connect("form_completed", Callable(self, "_on_form_completed"))

func _on_form_completed(acertos: int, total_perguntas: int):
	Global.add_score(acertos * 50)
	print("[JESSIKA] Pontos processados (não bloqueia transição)")

	var ui_layer = get_tree().current_scene.get_node("UI")
	dialog_instance = dialog_scene.instantiate()
	ui_layer.add_child(dialog_instance)

	await dialog_instance.set_text("Você concluiu a atividade! Pontuação: %d/%d (+%d pontos)" % [acertos, total_perguntas, acertos * 50], 3.5)

	dialog_instance.queue_free()
	dialog_instance = null

	if form_instance:
		form_instance.queue_free()
		form_instance = null
