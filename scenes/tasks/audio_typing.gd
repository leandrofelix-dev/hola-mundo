extends Node2D

var phrases = [
	{ "audio": "res://assets/audio/click1.ogg", "text": "1" },
	{ "audio": "res://assets/audio/click2.ogg", "text": "2" },
	{ "audio": "res://assets/audio/click3.ogg", "text": "3" },
	{ "audio": "res://assets/audio/click4.ogg", "text": "4" },
	{ "audio": "res://assets/audio/click5.ogg", "text": "5" },
]

var current_index = 0

@onready var label = $CanvasLayer/MainLabel
@onready var input_field = $CanvasLayer/InputField
@onready var result_label = $CanvasLayer/ResultLabel
@onready var check_button = $CanvasLayer/CheckButton
@onready var replay_button = $CanvasLayer/ReplayButton
@onready var audio_player = $AudioPlayer

func _ready():
	label.text = "Ingresa lo que escuchaste:"
	result_label.text = ""
	check_button.pressed.connect(verificar_resposta)
	replay_button.pressed.connect(tocar_audio)
	tocar_audio()

func tocar_audio():
	var audio_stream = load(phrases[current_index]["audio"])
	audio_player.stream = audio_stream
	audio_player.play()

func verificar_resposta():
	var resposta = input_field.text.strip_edges()
	var correta = phrases[current_index]["text"]

	if resposta == correta:
		result_label.text = "✔️ Correcto!"
	else:
		result_label.text = "❌ Incorrecto! Respuesta: %s" % correta

	await get_tree().create_timer(2.0).timeout

	current_index += 1
	if current_index >= phrases.size():
		label.text = "¡Escucha evaluada!"
		input_field.editable = false
		check_button.disabled = true
		replay_button.disabled = true
	else:
		input_field.text = ""
		result_label.text = ""
		tocar_audio()
