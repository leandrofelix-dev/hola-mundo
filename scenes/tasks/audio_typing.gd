extends Node2D

var phrases = [
	{ "audio": "res://assets/audio/frase01.mp3", "text": "trabajo", "trad": "trabalho" },
	{ "audio": "res://assets/audio/frase02.mp3", "text": "soy un estudiante", "trad": "sou um estudante" },
	{ "audio": "res://assets/audio/frase03.mp3", "text": "yo vengo de brasil", "trad": "eu venho do brasil" },
	{ "audio": "res://assets/audio/frase04.mp3", "text": "a qué hora termina el trabajo", "trad": "que horas termina o trabalho" },
	{ "audio": "res://assets/audio/frase05.mp3", "text": "contrato de trabajo", "trad": "contrato de trabalho" },
	{ "audio": "res://assets/audio/frase06.mp3", "text": "soy becario", "trad": "sou estagiário" },
	{ "audio": "res://assets/audio/frase07.mp3", "text": "vacante", "trad": "vaga" },
	{ "audio": "res://assets/audio/frase08.mp3", "text": "mi currículum", "trad": "meu currículo" },
	{ "audio": "res://assets/audio/frase09.mp3", "text": "día laborable", "trad": "dia útil" },
	{ "audio": "res://assets/audio/frase10.mp3", "text": "trabajas jornada parcial o jornada completa?", "trad": "trabalhas a jornada parcial ou a jornada completa?" },
	{ "audio": "res://assets/audio/frase11.mp3", "text": "te dieron o dan algún tipo de capacitación o entrenamiento para tu trabajo?", "trad": "você recebeu ou oferece algum tipo de treinamento ou treinamento para o seu trabalho?" }
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
	var resposta = normalizar(input_field.text)
	var correta = normalizar(phrases[current_index]["text"])
	var traducao = phrases[current_index]["trad"]

	if resposta == correta:
		result_label.text = "✔️ Correcto!\nTraducción: %s" % traducao
	else:
		result_label.text = "❌ Incorrecto!\nRespuesta: %s\nTraducción: %s" % [phrases[current_index]["text"], traducao]

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

func normalizar(text):
	text = text.strip_edges().to_lower()
	text = text.replace(".", "").replace(",", "").replace("!", "").replace("¿", "").replace("¡", "").replace("?", "")
	text = " ".join(text.split(" ", false)) # Remove espaços duplicados
	return remover_acentos(text)


func remover_acentos(text):
	var acentuados = ["á", "à", "ã", "â", "é", "è", "ê", "í", "ì", "î", "ó", "ò", "ô", "õ", "ú", "ù", "û", "ñ", "ü"]
	var sem_acento = ["a", "a", "a", "a", "e", "e", "e", "i", "i", "i", "o", "o", "o", "o", "u", "u", "u", "n", "u"]
	for i in range(acentuados.size()):
		text = text.replace(acentuados[i], sem_acento[i])
	return text
