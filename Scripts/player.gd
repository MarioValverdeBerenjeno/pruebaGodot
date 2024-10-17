extends CharacterBody2D

const SPEED = 130.0
const JUMP_VELOCITY = -300.0

const DASH_VELOCITY = 400.0
var dashing = false
var can_dash = true

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var bala = preload("res://Scenes/bala.tscn")
var balaIns

func _physics_process(delta: float) -> void:
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("move_left", "move_right")
	
	disparar()
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	if Input.is_action_just_pressed("dash") and can_dash:
		dashing = true
		can_dash = false
		$dash_timer.start()
		$can_dash_timer.start()
	
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true
		
	if is_on_floor():
		if direction == 0 and !dashing:
			animated_sprite.play("idle")
		else:
			animated_sprite.play("run")
	else:
		animated_sprite.play("jump")
	
	if direction:
		if dashing:
			velocity.x = direction * DASH_VELOCITY
		else:
			velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

# Stop dashing
func _on_dash_time_timeout() -> void:
	dashing = false

func _on_can_dash_timer_timeout() -> void:
	can_dash = true

func disparar():
	if Input.is_action_just_pressed("disparar"):
		balaIns = bala.instantiate()
		get_parent().add_child(balaIns)
		balaIns.position = self.position
		balaIns.apply_impulse(Vector2(0,0), Vector2(1000,0))
		
