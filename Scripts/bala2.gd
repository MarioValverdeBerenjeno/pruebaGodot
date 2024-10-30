extends Area2D

var speed = 200
var body_position:
	set(new_body_position):
		body_position = new_body_position
	get:
		return body_position

func _ready():
	$DestroyTimer.start()
		
func _physics_process(delta):
	if !body_position:
		position += transform.x * speed * delta
	else:
		position -= transform.x * speed * delta

func _on_body_entered(body):
	if body.is_in_group("enemy"):
		body.queue_free()
	queue_free()

func _on_destroy_timer_timeout():
	self.queue_free()
