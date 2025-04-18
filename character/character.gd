extends CharacterBody2D

const SPEED = 300.0

func _ready():
	$AnimatedSprite2D.play("idle")

func _physics_process(delta: float) -> void:
	var input_direction := Vector2(
		Input.get_axis("ui_left", "ui_right"),
		Input.get_axis("ui_up", "ui_down")
	)

	if input_direction != Vector2.ZERO:
		input_direction = input_direction.normalized()
		velocity = input_direction * SPEED
		
		if input_direction.x != 0 && input_direction.y == 0:
			$AnimatedSprite2D.play("walking_left_right")
			$AnimatedSprite2D.flip_h = input_direction.x > 0
		
		if input_direction.y != 0:
			$AnimatedSprite2D.play("walking_up")
			$AnimatedSprite2D.flip_v = input_direction.y > 0
		
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.y = move_toward(velocity.y, 0, SPEED)
		$AnimatedSprite2D.play("idle")

	move_and_slide()
