extends CharacterBody2D

const SPEED = 100.0
var screen_size: Vector2    = Vector2()
var idle_change_time: float = 1.0
var idle_timer: float       = 0.0

func is_colliding() -> bool:
	var collision: KinematicCollision2D = move_and_collide(velocity)
	if collision:
		return true
	else:
		return false


func _ready():
	screen_size = get_viewport_rect().size


func _process(delta):
	var velocity: Vector2        = Vector2()
	var input_direction: Vector2 = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * SPEED

	if velocity.length() > 0:
		# Normalize velocity to maintain constant speed in all directions
		velocity = velocity.normalized() * SPEED
		position += velocity * delta
		is_colliding()

		$AnimatedSprite2D.play("walk")
		$AnimatedSprite2D.flip_h = velocity.x < 0

		idle_timer = 0.0
	else:
		if $AnimatedSprite2D.animation == "idle1" or $AnimatedSprite2D.animation == "idle2":
			idle_timer += delta
		else:
			$AnimatedSprite2D.play("idle1")

		if idle_timer >= idle_change_time:
			# Reset the timer after changing the animation
			idle_timer = 0.0

			# Randomly choose between idle1 and idle2 (idle2 has a 20% chance of being chosen)
			var random_idle: float = randf()
			if random_idle < 0.2:
				$AnimatedSprite2D.play("idle2")
			else:
				$AnimatedSprite2D.play("idle1")
