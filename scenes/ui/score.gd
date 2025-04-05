extends Control

@onready var label = $PanelContainer/Label

func _ready():
	add_to_group("score_ui")
	print("[SCORE] Registrado no grupo 'score_ui'")
	update_score()

func update_score():
	if has_node("/root/Global"):
		label.text = str(get_node("/root/Global").score) + " pts"
		print("[SCORE] Atualizado para:", get_node("/root/Global").score)
	else:
		printerr("[SCORE] Global não encontrado!")
