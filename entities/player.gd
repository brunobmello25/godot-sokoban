extends CharacterBody2D

const SPEED = 300.0

var last_direction: Vector2 = Vector2.DOWN
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite: Sprite2D = $Sprite2D


func _physics_process(delta: float) -> void:
	position += get_direction().normalized() * SPEED * delta

	move_and_slide()


func _process(_delta: float) -> void:
	_update_animation()


func get_direction() -> Vector2:
	var direction = Vector2.ZERO
	direction.x = Input.get_axis("move_left", "move_right")
	direction.y = Input.get_axis("move_up", "move_down")
	if direction != Vector2.ZERO:
		last_direction = direction.normalized()
	return direction


func _update_animation() -> void:
	sprite.flip_h = _should_flip_animation()
	if get_direction() == Vector2.ZERO:
		animation_player.play(_pick_idle_animation())
	else:
		animation_player.play(_pick_walk_animation())


func _pick_idle_animation() -> String:
	if last_direction.x == 0 and last_direction.y > 0:
		return "idle_front"
	elif last_direction.x == 0 and last_direction.y < 0:
		return "idle_back"
	else:
		return "idle_side"


func _pick_walk_animation() -> String:
	if last_direction.x == 0 and last_direction.y > 0:
		return "walk_front"
	elif last_direction.x == 0 and last_direction.y < 0:
		return "walk_back"
	else:
		return "walk_side"


func _should_flip_animation() -> bool:
	return last_direction.x < 0
