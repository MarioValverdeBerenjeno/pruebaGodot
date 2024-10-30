extends CharacterBody2D
class_name Player

const SPEED = 130.0
const JUMP_VELOCITY = -300.0

const DASH_VELOCITY = 400.0
var dashing = false
var can_dash = true
var can_shoot = true
var can_shoot2 = true

var player_health = Global.player_health

@onready var collider = $CollisionShape2D
@onready var timer: Timer = $DeathTimer
@onready var labelNode: Label = $"../Score/UI/Base/Vida"
@onready var labelNodeScore: Label = $"../Score/UI/Base/Label"

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var bala = preload("res://Scenes/bala.tscn")
var balaIns

@onready var bala2 = preload("res://Scenes/bala2.tscn")
var balaIns2

func _ready() -> void:
	labelNode.text = "Health: " + str(Global.player_health)
	player_health = Global.player_health
	labelNodeScore.text = "Score: " + str(Global.player_score)

func _physics_process(delta: float) -> void:
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("move_left", "move_right")
	
	disparar()
	disparar2()
	
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
		
	#if is_on_floor(): HECHO CON MÁQUINA DE ESTADOS
		#if direction == 0 and !dashing:
		#	animated_sprite.play("idle")
		#else:
			#animated_sprite.play("run")
	#else:
		#animated_sprite.play("jump")
	
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

func _on_cd_bullet_timeout():
	can_shoot = true

func _on_cd_bullet_2_timeout():
	can_shoot2 = true

func disparar() -> void:
	if Input.is_action_just_pressed("disparar") && can_shoot:
		can_shoot = false
		$cd_bullet.start()
		balaIns = bala.instantiate()
		get_parent().add_child(balaIns)
		if !animated_sprite.flip_h:		
			balaIns.position.x = self.position.x + 10
			balaIns.position.y = self.position.y -10
			balaIns.apply_impulse(Vector2(200,-300), Vector2(0,0))
		else:
			balaIns.position.x = self.position.x - 10
			balaIns.position.y = self.position.y -10
			balaIns.apply_impulse(Vector2(-200,-300), Vector2(0,0))

func disparar2() -> void:
	if Input.is_action_just_pressed("disparar2") && can_shoot2:
		can_shoot2 = false
		$cd_bullet2.start()
		balaIns2 = bala2.instantiate()
		get_parent().add_child(balaIns2)
		balaIns2.body_position = animated_sprite.flip_h
		balaIns2.global_position = collider.global_position

func recibirDaño(daño: int):
	player_health -= daño
	Global.player_health = player_health
	labelNode.text = "Health: " + str(Global.player_health)
	if(player_health <= 0):
		Engine.time_scale = 0.5
		get_node("CollisionShape2D").queue_free()
		timer.start()

func _on_death_timer_timeout() -> void:
	Engine.time_scale = 1.0
	get_tree().reload_current_scene()
	Global.player_health = 100
	Global.player_score = 0
