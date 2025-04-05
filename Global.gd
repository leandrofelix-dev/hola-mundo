extends Node

var score: int = 0

func add_score(points: int):
	score += points
	print("[GLOBAL] Score atual:", score)
	
	# Atualização direta como fallback
	var score_ui = get_tree().get_first_node_in_group("score_ui")
	if score_ui:
		score_ui.update_score()
	else:
		printerr("[GLOBAL] UI não encontrada - atualize manualmente")

func notify_score_update() -> void:
	for node in get_tree().get_nodes_in_group("score_ui"):
		node.update_score()

func load_score() -> void:
	if FileAccess.file_exists("user://score.save"):
		var file = FileAccess.open("user://score.save", FileAccess.READ)
		score = file.get_var()
		print("[GLOBAL] Score carregado: ", score)

func save_score() -> void:
	var file = FileAccess.open("user://score.save", FileAccess.WRITE)
	file.store_var(score)
