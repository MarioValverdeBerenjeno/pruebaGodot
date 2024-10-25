extends RigidBody2D

func _on_body_entered(body):
	print("AY")
	if body.is_in_group("enemy"):
		print("choque")
		body.queue_free()
