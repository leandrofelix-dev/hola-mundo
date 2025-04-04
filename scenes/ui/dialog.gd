extends Control

@onready var label = $Panel/Label
@onready var timer = $Timer

func set_text(text: String, duration: float = 2.5):
	label.text = text
	timer.start(duration)

func _on_timer_timeout() -> void:
	queue_free()
	pass
