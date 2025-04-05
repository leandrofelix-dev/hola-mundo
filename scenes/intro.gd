extends Node2D

var office_scene = preload("res://scenes/maps/office.tscn")
@onready var label = $CanvasLayer/RichTextLabel
@onready var timer = $Timer
@onready var background = $Background

var pause_menu: PackedScene = preload("res://scenes/ui/pause_menu.tscn")

var bg_images = [
	preload("res://assets/bg_school.png"),
	preload("res://assets/bg_plane.png"),
	preload("res://assets/bg_arrival.png"),
	preload("res://assets/bg_office.png"),
]

var textos = [
	"Pedro, estudante de tecnologia no IFCE, recebe sua primeira grande chance.",
	"Uma vaga na LaCoda, empresa espanhola de tecnologia.",
	"Mais que uma simples entrevista ou teste.",
	"Seu desafio é o dia a dia real.",
	"Se comunicando com falantes nativos do espanhol",
	"Durante 24 horas, ele vai encarar tarefas como um funcionário da empresa.",
	"Emails, reuniões, mensagens... e nenhuma delas em português.",
	"No fim do dia, vem a resposta: contratado ou não.",
	"Se ele conseguir se virar, a vaga é garantida.",
	"Se não, volta pra casa com só mais uma história pra contar.",
	"Topa esse desafio?",
]
var index = 0

func _ready():
	label.text = ""
	label.visible_ratio = 0
	background.texture = bg_images[0]
	mostrar_proximo_texto()

func atualizar_background():
	if index <= 2:
		background.texture = bg_images[0] # escola
	elif index <= 4:
		background.texture = bg_images[1] # avião
	elif index <= 6:
		background.texture = bg_images[2] # chegada
	else:
		background.texture = bg_images[3] # escritório

func mostrar_proximo_texto():
	if index >= textos.size():
		var final_tween = create_tween()
		final_tween.tween_property(label, "modulate:a", 0, 1.5)\
				  .set_ease(Tween.EASE_IN)\
				  .set_trans(Tween.TRANS_CUBIC)
		await final_tween.finished
		get_tree().change_scene_to_packed(office_scene)
		return
	
	atualizar_background()

	label.text = textos[index]
	label.modulate.a = 0
	label.visible_ratio = 0
	
	var fade_tween = create_tween()
	fade_tween.tween_property(label, "modulate:a", 1, 0.8)\
			 .set_ease(Tween.EASE_OUT)\
			 .set_trans(Tween.TRANS_SINE)
	
	var type_tween = create_tween()
	type_tween.tween_property(label, "visible_ratio", 1, textos[index].length() * 0.03)\
			 .set_ease(Tween.EASE_IN_OUT)\
			 .set_trans(Tween.TRANS_LINEAR)
	
	index += 1
	await type_tween.finished
	
	timer.wait_time = 2.0
	timer.start()
	await timer.timeout
	
	mostrar_proximo_texto()

func _on_timer_timeout():
	pass
