extends Area2D

@onready var timer: Timer = $Timer

func _on_body_entered(body):
	if body.is_in_group("player"):
		Engine.time_scale = 0.5
		body.get_node("CollisionShape2D").queue_free()
		timer.start()
	elif body.is_in_group("bala") && self.get_parent().is_in_group("enemy"):
		body.queue_free()
		self.get_parent().queue_free()

func _on_timer_timeout() -> void:
	Engine.time_scale = 1.0
	get_tree().reload_current_scene()
