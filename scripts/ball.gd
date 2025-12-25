extends RigidBody2D

func _ready():
	self.gravity_scale = 0
	self.linear_damp = 1.0

func _physics_process(delta):
	if linear_velocity.length() < 2:
		Global.ball_stopped = true
	else:
		Global.ball_stopped = false
	
	var collision = move_and_collide(linear_velocity * delta)
	if collision:
		if linear_velocity.length() > 2:
			$hit.play()
		linear_velocity = linear_velocity.bounce(collision.get_normal())

func _on_area_2d_area_entered(area):
	if area.is_in_group("player"):
		linear_velocity=Vector2(0,0)
		
	if area.is_in_group("hole"):
		Global.ball_stopped = true
		Global.win = true
		queue_free()
	
	if area.is_in_group("explosion"):
		var ball_position = area.global_position
		var explosion_range = 170
		var full_force = 2000
		var direction = (global_position - ball_position).normalized()
		var distance = (global_position - ball_position).length()
		var falloff = clamp(1.0 - (distance / explosion_range), 0.0, 1.0)
		var explosion_force = direction * full_force * falloff
		linear_velocity += explosion_force

