extends RigidBody2D
func _ready():
   connect("body_entered", Callable(self, "_on_body_entered"))

func _on_body_entered(body):
   queue_free()
