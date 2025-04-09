extends Node2D

@onready var anim = $AnimatedSprite2D
@onready var area: Area2D = $Area2D

var dialog_instance: Control = null

@export var dialog_scene: PackedScene = load("res://scenes/ui/dialog.tscn")

func _ready():
	if area:
		area.body_entered.connect(_on_body_entered)
	else:
		print("Area2D não foi encontrada!")

func _physics_process(_delta):
	anim.play("idle")

func _on_body_entered(body):
	if body is CharacterBody2D and dialog_instance == null:
		await _mostrar_dialogo("Pedro: ¡Hola!", 2.0)
		await _mostrar_dialogo("Jefe: te llamé aquí porque ya tenemos un veredicto.", 5.0)
		await _mostrar_dialogo("Jefe: sobre tu contratación.", 4.0)
		await _mostrar_dialogo("Jefe: tienes una puntuación de: " + str(Global.score), 4.0)
		await _mostrar_dialogo("Jefe: dicho esto te informo que: ", 4.0)

		if Global.score >= 300:
			await _mostrar_dialogo("Jefe: ¡Eres el nuevo miembro de la empresa! ¡Felicidades!", 4.0)
		else:
			await _mostrar_dialogo("Jefe: No fue esta vez. No cumpliste con los requisitos", 4.0)
		
		await get_tree().create_timer(1.0).timeout
		get_tree().change_scene_to_file("res://scenes/ui/theend.tscn")

func _mostrar_dialogo(texto: String, tempo: float):
	var ui_layer = get_tree().current_scene.get_node("UI")
	if not ui_layer:
		printerr("UI não encontrado!")
		return

	# Remove o diálogo anterior
	if dialog_instance and dialog_instance.is_inside_tree():
		dialog_instance.queue_free()
		await get_tree().create_timer(0.1).timeout

	dialog_instance = dialog_scene.instantiate()
	ui_layer.add_child(dialog_instance)
	await dialog_instance.set_text(texto, tempo)
