extends CharacterBody2D

@export var max_speed: float = 120.0
@export var acceleration: float = 5.0
@export var friction: float = 8.0
var can_move: bool = true

func _physics_process(delta):
	if not can_move:
		return

	var direction = Vector2.ZERO

	if Input.is_action_pressed("ui_right"):
		direction.x += 1
		$Sprite2D.flip_h = false
	if Input.is_action_pressed("ui_left"):
		direction.x -= 1
		$Sprite2D.flip_h = true
	if Input.is_action_pressed("ui_down"):
		direction.y += 1
	if Input.is_action_pressed("ui_up"):
		direction.y -= 1

	# Movimento mais fluido com move_toward()
	if direction != Vector2.ZERO:
		velocity = velocity.move_toward(direction.normalized() * max_speed, acceleration * delta * 100)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, friction * delta * 100)

	move_and_slide()
