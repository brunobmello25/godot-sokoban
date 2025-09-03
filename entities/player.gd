extends CharacterBody2D

const SPEED = 300.0


func _physics_process(delta: float) -> void:
	position += get_direction() * SPEED * delta

	move_and_slide()


func get_direction() -> Vector2:
	var direction = Vector2.ZERO
	direction.x = Input.get_axis("move_left", "move_right")
	direction.y = Input.get_axis("move_up", "move_down")
	return direction.normalized()
