extends Node2D

@onready var anim = $AnimatedSprite2D

func _physics_process(delta):
	anim.play("idle") 
