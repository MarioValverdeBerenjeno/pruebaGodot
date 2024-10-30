extends RigidBody2D

func _ready():
	$DestroyTimer.start()

func _on_destroy_timer_timeout():
	self.queue_free()
