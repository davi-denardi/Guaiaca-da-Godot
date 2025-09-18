extends CharacterBody2D

@onready var i=0
@onready var player_anim = $Sprites
const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var restart_color = Color(1.0, 0.259, 0.188, 0.769)
var normal_color = Color(1.0, 1.0, 1.0, 1.0)
@onready var camera = $"../Camera2D"

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction < 0:
		player_anim.flip_h = true
		player_anim.play("run")
	if direction > 0:
		player_anim.flip_h = false
		player_anim.play("run")
	if direction == 0:
		player_anim.play("idle")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	if position.y>550:
		var tween = get_tree().create_tween()
		tween.tween_property($".", "modulate", restart_color, 0.6)
		if i>50:
			tween.tween_property($".", "modulate", normal_color, 0.6)
			$Particulas.emitting = true
			position.y=0
			position.x=115
			i=0
		i=i+1
	else:
		camera.position = position

	move_and_slide()
