extends Node2D

@onready var anim = $AnimatedSprite2D
@onready var area: Area2D = $Area2D

var dialog_instance: Control = null
var form_instance: Control = null

@export var dialog_scene: PackedScene = preload("res://scenes/ui/dialog.tscn")
@export var report_scene: PackedScene = preload("res://scenes/tasks/form.tscn")

func _ready():
	if area:
		area.body_entered.connect(_on_body_entered)
	else:
		printerr("Area2D não encontrada!")

func _physics_process(_delta):
	anim.play("idle")

func _on_body_entered(body):
	if body is CharacterBody2D and dialog_instance == null:
		dialog_instance = dialog_scene.instantiate()
		var ui_layer = get_tree().current_scene.get_node("UI")
		if ui_layer:
			ui_layer.add_child(dialog_instance)
			await dialog_instance.set_text("Pedro: Hola soy pedro vine a hacer la prueba.", 5.0)

			dialog_instance = dialog_scene.instantiate()
			ui_layer.add_child(dialog_instance)
			await dialog_instance.set_text("Maria: ¡Bienvenido Pedro! Soy María, gerente de contratación.", 6.0)
			
			dialog_instance = dialog_scene.instantiate()
			ui_layer.add_child(dialog_instance)
			await dialog_instance.set_text("Maria: Primero, complete el formulario de consentimiento en la mesa para que podamos conocernos mejor.", 8.0)
			
			dialog_instance.queue_free()
			dialog_instance = null
			await get_tree().create_timer(0.5).timeout

			show_form(ui_layer)

func show_form(ui_layer: Node):
	if form_instance == null:
		form_instance = report_scene.instantiate()
		ui_layer.add_child(form_instance)
		
		# Conexão segura com verificação
		var callable = Callable(self, "_on_form_completed")
		if form_instance.has_signal("form_completed"):
			if not form_instance.is_connected("form_completed", callable):
				var result = form_instance.connect(
					"form_completed",
					callable,
					CONNECT_DEFERRED | CONNECT_PERSIST
				)
				if result == OK:
					print("[RH] Conexão do sinal realizada com sucesso!")
				else:
					printerr("[RH] ERRO na conexão:", result)
		else:
			printerr("[RH] Sinal form_completed não encontrado no formulário!")

func _on_form_completed(acertos: int, total_perguntas: int):
	Global.add_score(acertos * 50)
	print("[RH] Pontos processados (não bloqueia transição)")

	var ui_layer = get_tree().current_scene.get_node("UI")

	dialog_instance = dialog_scene.instantiate()
	ui_layer.add_child(dialog_instance)
	await dialog_instance.set_text("Maria: ¡Muy bien!", 3)

	dialog_instance = dialog_scene.instantiate()
	ui_layer.add_child(dialog_instance)
	await dialog_instance.set_text("*Pontuação: %d/%d  (+%d pontos)" % [acertos, total_perguntas, acertos * 50], 5)

	dialog_instance = dialog_scene.instantiate()
	ui_layer.add_child(dialog_instance)
	await dialog_instance.set_text("Maria: Tu supervisora, Jessika, está en el comedor, en el lado izquierdo de la oficina. ve a hablar con ella", 8)

	dialog_instance.queue_free()
	dialog_instance = null
