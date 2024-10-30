extends PlayerState

func enter():
	player.animated_sprite.play("idle")

func process(delta: float):
	var direction := Input.get_axis("move_left", "move_right")
	if direction && player.is_on_floor():
		state_machine.change_to("PlayerStateRun")
	elif !player.is_on_floor():
		state_machine.change_to("PlayerStateJump")
