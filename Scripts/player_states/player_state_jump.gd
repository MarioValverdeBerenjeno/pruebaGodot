extends PlayerState

func enter():
	player.animated_sprite.play("jump")

func process(delta: float) -> void:
	var direction := Input.get_axis("move_left", "move_right")
	if direction == 0 && player.is_on_floor():
		state_machine.change_to("PlayerStateIdle")
	elif direction && player.is_on_floor():
		state_machine.change_to("PlayerStateRun")
