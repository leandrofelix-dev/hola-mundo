extends Control

signal form_completed(acertos: int, total_perguntas: int)

@onready var vbox = $VBoxContainer
var office_scene: PackedScene = preload("res://scenes/maps/office.tscn")
var rh_scene: PackedScene = preload("res://scenes/characters/rh_lead/rh.tscn")
var ui_layer: Node = null

var perguntas = [
	{
		"texto": "Declaro que yo",
		"opcoes": ["Pedro", "Irineu"],
		"correta": "Pedro"
	},
	{
		"texto": "estoy empezando el proceso de",
		"opcoes": ["prueba", "renuncia"],
		"correta": "prueba"
	},
	{
		"texto": "en",
		"opcoes": ["LaCoda", "Google"],
		"correta": "LaCoda"
	},
	{
		"texto": "cuya lengua materna es el",
		"opcoes": ["español", "portugués"],
		"correta": "español"
	},
	{
		"texto": "con sede en",
		"opcoes": ["España - Portugal", "Cedro - Brasil"],
		"correta": "España - Portugal"
	},
	{
		"texto": "y se espera que esté terminado en",
		"opcoes": ["1 día", "400 años"],
		"correta": "1 día"
	}
]

func _ready():
	for pergunta in perguntas:
		var hbox = HBoxContainer.new()

		var label = Label.new()
		label.text = pergunta.texto
		label.modulate = Color(0.1, 0.1, 0.1)
		label.add_theme_font_size_override("font_size", 32)
		hbox.add_child(label)

		var opcao = OptionButton.new()
		opcao.add_theme_font_size_override("font_size", 26)

		opcao.add_item("Seleccionar...")
		opcao.set_item_disabled(0, true)

		for op in pergunta.opcoes:
			opcao.add_item(op)

		opcao.select(0)
		opcao.set_meta("correta", pergunta.correta)

		hbox.add_child(opcao)
		vbox.add_child(hbox)

	var spacer = Control.new()
	spacer.custom_minimum_size = Vector2(0, 20)
	vbox.add_child(spacer)

	var botao = Button.new()
	botao.text = "Entregar"
	botao.add_theme_font_size_override("font_size", 26)
	botao.pressed.connect(_validar_respostas)
	vbox.add_child(botao)

func _validar_respostas():
	for hbox in vbox.get_children():
		if hbox is HBoxContainer:
			var opcao = hbox.get_child(1)
			if opcao.selected == 0:
				print("Responda todas as perguntas!")
				return

	var acertos = 0
	for hbox in vbox.get_children():
		if hbox is HBoxContainer:
			var opcao = hbox.get_child(1)
			var resposta = opcao.get_item_text(opcao.selected)
			var correta = opcao.get_meta("correta")
			if resposta == correta:
				acertos += 1

	emit_signal("form_completed", acertos, perguntas.size())
	
	# Garante que o sinal seja processado
	await get_tree().process_frame
	
	# Troca de cena COM FALLBACK
	if office_scene and office_scene.can_instantiate():
		# Remove o formulário antes de trocar
		queue_free()  
		
		# Método mais confiável para trocar cenas
		get_tree().change_scene_to_packed(office_scene)
		print("[FORM] Cena trocada com SUCESSO para office.tscn")
	else:
		printerr("[FORM] FALHA: office_scene inválida!")
		# Fallback visual
		visible = false
