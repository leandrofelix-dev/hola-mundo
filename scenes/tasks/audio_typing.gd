extends Node2D

signal form_completed(pontuacao, total)

var phrases = [
	{ "audio": "res://assets/audio/frase01.mp3", "text": "trabajo", "trad": "trabalho" },
	{ "audio": "res://assets/audio/frase02.mp3", "text": "soy un estudiante", "trad": "sou um estudante" },
	{ "audio": "res://assets/audio/frase03.mp3", "text": "yo vengo de brasil", "trad": "eu venho do brasil" },
	{ "audio": "res://assets/audio/frase04.mp3", "text": "¿a qué hora termina el trabajo?", "trad": "que horas termina o trabalho?" },
	{ "audio": "res://assets/audio/frase05.mp3", "text": "contrato de trabajo", "trad": "contrato de trabalho" },
	{ "audio": "res://assets/audio/frase06.mp3", "text": "soy becario", "trad": "sou bolsista" },
	{ "audio": "res://assets/audio/frase07.mp3", "text": "vacante", "trad": "vaga" },
	{ "audio": "res://assets/audio/frase08.mp3", "text": "mi currículum", "trad": "meu currículo" },
	{ "audio": "res://assets/audio/frase09.mp3", "text": "día laborable", "trad": "dia útil" },
	{ "audio": "res://assets/audio/frase10.mp3", "text": "¿trabajas jornada parcial o jornada completa?", "trad": "trabalhas a jornada parcial ou a jornada completa?" },
	{ "audio": "res://assets/audio/frase11.mp3", "text": "¿te dieron o dan algún tipo de capacitación o entrenamiento para tu trabajo?", "trad": "você recebeu ou recebe algum tipo de capacitação ou treinamento para o seu trabalho?" }
]

@onready var label = $CanvasLayer/MainLabel
@onready var input_field = $CanvasLayer/InputField
@onready var result_label = $CanvasLayer/ResultLabel
@onready var check_button = $CanvasLayer/CheckButton
@onready var replay_button = $CanvasLayer/ReplayButton
@onready var audio_player = $AudioPlayer

var current_index = 0
var audio_finalizado = false
var resposta_enviada = false
var acertos = 0

func _ready():
	audio_player.finished.connect(_on_audio_finalizado)
	check_button.pressed.connect(verificar_resposta)
	replay_button.pressed.connect(tocar_audio)
	input_field.text_changed.connect(_on_text_changed)
	tocar_audio()

func tocar_audio():
	audio_finalizado = false
	resposta_enviada = false
	check_button.disabled = true
	var audio_stream = load(phrases[current_index]["audio"])
	audio_player.stream = audio_stream
	audio_player.play()

func _on_audio_finalizado():
	audio_finalizado = true
	verificar_estado_do_botao()

func _on_text_changed(new_text):
	verificar_estado_do_botao()

func verificar_estado_do_botao():
	check_button.disabled = !(audio_finalizado and input_field.text.strip_edges() != "" and !resposta_enviada)

func verificar_resposta():
	if resposta_enviada:
		return
	resposta_enviada = true
	check_button.disabled = true

	var resposta = normalizar(input_field.text)
	var correta = normalizar(phrases[current_index]["text"])
	var traducao = phrases[current_index]["trad"]

	if resposta == correta:
		result_label.text = "✔️ Correcto!\n🇧🇷 Traducción: %s" % traducao
		acertos += 1
	else:
		result_label.text = "❌ Incorrecto!\n🇪🇸 Respuesta: %s\n🇧🇷 Traducción: %s" % [phrases[current_index]["text"], traducao]

	await get_tree().create_timer(4.0).timeout

	current_index += 1
	if current_index >= phrases.size():
		label.text = "¡Escucha finalizada!"
		result_label.text = "Tu puntaje: %d/%d" % [acertos, phrases.size()]
		input_field.editable = false
		check_button.disabled = true
		replay_button.disabled = true

		await get_tree().create_timer(3.0).timeout

		emit_signal("form_completed", acertos, phrases.size())
		get_parent().remove_child(self)
		queue_free()
	else:
		input_field.text = ""
		result_label.text = ""
		tocar_audio()

func normalizar(text):
	text = text.strip_edges().to_lower()
	text = text.replace(".", "").replace(",", "").replace("!", "").replace("¿", "").replace("¡", "").replace("?", "")
	text = " ".join(text.split(" ", false))
	return remover_acentos(text)

func remover_acentos(text):
	var acentuados = ["á", "à", "ã", "â", "é", "è", "ê", "í", "ì", "î", "ó", "ò", "ô", "õ", "ú", "ù", "û", "ñ", "ü"]
	var sem_acento = ["a", "a", "a", "a", "e", "e", "e", "i", "i", "i", "o", "o", "o", "o", "u", "u", "u", "n", "u"]
	for i in range(acentuados.size()):
		text = text.replace(acentuados[i], sem_acento[i])
	return text
