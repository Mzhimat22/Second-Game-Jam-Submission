extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	pass
	#for o in get_overlapping_bodies():
		#if o is RigidBody2D:
			#var force = (o.global_position - global_position).normalized()
			#force *= 400
			#o.apply_central_impulse(force)


func _on_timer_timeout():
	queue_free()


