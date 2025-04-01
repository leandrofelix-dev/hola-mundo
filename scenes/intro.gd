extends Node2D

var office_scene: PackedScene = preload("res://scenes/maps/office.tscn")

@onready var story_label = $CanvasLayer/RichTextLabel

func _ready():
	story_label.text = """
		[center][b]Ano 2094 - Estação Lunar Omega[/b][/center]
		
		A humanidade expandiu suas fronteiras para além da Terra.  
		Você, um especialista em segurança cibernética, recebeu uma missão urgente:  
		Um ataque hacker comprometeu os sistemas da estação.

		Sua primeira tarefa? Descobrir quem está por trás disso.

		[center][b]Prepare-se...[/b][/center]
		"""

	var timer = get_tree().create_timer(5)  
	await timer.timeout

	get_tree().change_scene_to_packed(office_scene)
