extends Control

@onready var vbox = $VBoxContainer

var perguntas = [
	{
		"texto": "Declaro que eu,",
		"opcoes": ["Pedro", "Irineu"],
		"correta": "Pedro"
	},
	{
		"texto": "estou dando inicio ao processo de",
		"opcoes": ["teste", "demissão"],
		"correta": "teste"
	},
	{
		"texto": "na empresa",
		"opcoes": ["LaCoda", "Google"],
		"correta": "LaCoda"
	},
	{
		"texto": "cuja lingua nativa é o",
		"opcoes": ["espanhol", "português"],
		"correta": "espanhol"
	},
	{
		"texto": "com sede em",
		"opcoes": ["Espanha - Portugal", "Cedro - Brasil"],
		"correta": "Espanha - Portugal"
	},
	{
		"texto": "e com previsão de conclusão em",
		"opcoes": ["1 dia", "400 anos"],
		"correta": "1 dia"
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

		# Opção inicial fantasma
		opcao.add_item("Selecione...")
		opcao.set_item_disabled(0, true)

		for op in pergunta.opcoes:
			opcao.add_item(op)

		opcao.select(0)  # Sempre começa na opção "Selecione..."
		opcao.set_meta("correta", pergunta.correta)

		hbox.add_child(opcao)
		vbox.add_child(hbox)

	var botao = Button.new()
	
	var spacer = Control.new()
	spacer.custom_minimum_size = Vector2(0, 20) # 20px de altura
	vbox.add_child(spacer)

	botao.text = "Entregar"
	botao.add_theme_font_size_override("font_size", 26)
	botao.pressed.connect(_validar_respostas)
	vbox.add_child(botao)	

func _validar_respostas():
	for hbox in vbox.get_children():
		if hbox is HBoxContainer:
			var opcao = hbox.get_child(1)
			if opcao.selected == 0:
				print("Você precisa responder todas as perguntas antes de validar!")
				return

	var acertos = 0
	for hbox in vbox.get_children():
		if hbox is HBoxContainer:
			var opcao = hbox.get_child(1)
			var resposta = opcao.get_item_text(opcao.selected)
			var correta = opcao.get_meta("correta")
			if resposta == correta:
				acertos += 1

	print("Acertos:", acertos, "/", perguntas.size())
