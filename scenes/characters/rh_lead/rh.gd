extends Node2D

@onready var anim = $AnimatedSprite2D
@onready var area: Area2D = $Area2D

var dialog_instance: Control = null

@export var dialog_scene: PackedScene = load("res://scenes/ui/dialog.tscn")
@export var report_scene: PackedScene = load("res://scenes/tasks/form.tscn")

func _ready():
	if area:
		area.body_entered.connect(_on_body_entered)
	else:
		print("Area2D não foi encontrada!")

func _physics_process(_delta):
	anim.play("idle")

func _on_body_entered(body):
	if body is CharacterBody2D and dialog_instance == null:
		dialog_instance = dialog_scene.instantiate()
		
		var ui_layer = get_tree().current_scene.get_node("UI")
		if ui_layer:
			ui_layer.add_child(dialog_instance)

			await dialog_instance.set_text("¡Bienvenido Pedro! Soy María, gerente de contratación.", 4.0)
			
			dialog_instance = dialog_scene.instantiate()
			ui_layer.add_child(dialog_instance)
			await dialog_instance.set_text("En primer lugar, complete el formulario de consentimiento para que podamos conocernos mejor.", 6.0)
			
			dialog_instance.queue_free()
			dialog_instance = null
			await get_tree().create_timer(0.5).timeout

			var report = report_scene.instantiate()
			ui_layer.add_child(report)
			report.visible = true
