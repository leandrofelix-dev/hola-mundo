extends CharacterBody2D

@export var max_speed: float = 60.0
@export var acceleration: float = 5.0
@export var friction: float = 10.0

var can_move: bool = true

@onready var anim = $AnimatedSprite2D

func _physics_process(delta):
	if not can_move:
		return

	var direction = Vector2.ZERO

	if Input.is_action_pressed("ui_right"):
		direction.x += 1
		anim.flip_h = false
	if Input.is_action_pressed("ui_left"):
		direction.x -= 1
		anim.flip_h = true
	if Input.is_action_pressed("ui_down"):
		direction.y += 1
	if Input.is_action_pressed("ui_up"):
		direction.y -= 1

	if direction != Vector2.ZERO:
		velocity = velocity.move_toward(direction.normalized() * max_speed, acceleration * delta * 100)
		
		# Animação diferente pra cima
		if direction.y < 0:
			anim.play("walk_up")
		else:
			anim.play("walk")
	else:
		velocity = velocity.move_toward(Vector2.ZERO, friction * delta * 100)
		anim.play("idle") 

	move_and_slide()
