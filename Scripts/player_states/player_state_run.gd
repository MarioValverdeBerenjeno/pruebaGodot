extends PlayerState

func enter():
	player.animated_sprite.play("run")

func process(delta: float):
	var direction := Input.get_axis("move_left", "move_right")
	if direction == 0 && player.is_on_floor():
		state_machine.change_to("PlayerStateIdle")
	elif !player.is_on_floor():
		state_machine.change_to("PlayerStateJump")
