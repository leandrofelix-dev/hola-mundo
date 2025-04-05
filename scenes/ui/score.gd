extends Control

@onready var label = $PanelContainer/Label

func set_score(value: int):
	label.text = str(value) + " pts"
