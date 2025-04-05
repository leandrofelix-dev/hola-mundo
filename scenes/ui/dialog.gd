extends Control

@onready var label = $Panel/Label

func set_text(texto: String, duracao: float, callback = null):
	label.text = texto
	await get_tree().create_timer(duracao).timeout
	queue_free()
	if callback:
		callback.call()
