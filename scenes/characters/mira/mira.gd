extends Node2D

@onready var anim = $AnimatedSprite2D
@onready var area: Area2D = $Area2D

var dialog_instance: Control = null

@export var dialog_scene: PackedScene = load("res://scenes/ui/dialog.tscn")

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

			await dialog_instance.set_text("Pedro: ¡Hola! Es mi primer día aquí. ¿Dónde está la sala de recursos humanos?", 6.0)

			dialog_instance = dialog_scene.instantiate()
			ui_layer.add_child(dialog_instance)
			await dialog_instance.set_text("Mira: ¡Por supuesto! ¡Bienvenido! Está abajo a la derecha. Busque a la chica gerente de contratación.", 8.0)
