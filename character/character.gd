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
		$AnimatedSprite2D.play("moving")
		
		# Flip character based on horizontal movement
		if input_direction.x != 0:
			$AnimatedSprite2D.flip_h = input_direction.x > 0
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.y = move_toward(velocity.y, 0, SPEED)
		$AnimatedSprite2D.play("idle")

	move_and_slide()
