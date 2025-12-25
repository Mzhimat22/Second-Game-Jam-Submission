extends CharacterBody2D

const SPEED = 300.0
var lives = Global.lives
var explosion = preload("res://scenes/explosion.tscn")
var direction = Vector2(0,0)
var start = true
# Get the gravity from the project settings to be synced with RigidBody nodes.

var isexploding = false

func _ready():
	Global.starting_lives = lives

func _physics_process(delta):
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	direction.x = Input.get_axis("left", "right")
	direction.y = Input.get_axis("up", "down")
	Global.lives = lives
	if lives == 0 and not Global.win and start:
		start = false
		Global.lose = true
	elif start:
		start = false
	
	if direction.x > 0 and not isexploding and not Global.win and not Global.lose:
		$CatSprite.flip_h = false
		$CollisionShape2D.position.x = 0
		$Area2D.position.x = 0
	elif direction.x < 0 and not isexploding and not Global.win and not Global.lose:
		$CatSprite.flip_h = true
		$CollisionShape2D.position.x = 45.5
		$Area2D.position.x = 45.5
	
	if direction and not isexploding and not Global.win and not Global.lose:
		$CatSprite.play("default")
		velocity.x = direction.x * SPEED
		velocity.y = direction.y * SPEED
	elif not isexploding and not Global.win and not Global.lose:
		$CatSprite.play("idle")
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.y = move_toward(velocity.y, 0, SPEED)
		
	#explode
	if Input.is_action_just_pressed("explode") and not isexploding and not Global.win and not Global.lose:
		explode()

	move_and_slide()

func explode():
	$CollisionShape2D.disabled = true
	$Area2D/CollisionShape2D.disabled = true
	$shriek.play()
	lives -= 1
	if lives == Global.starting_lives-2:
		Global.holeinone = "\n"
	velocity =  Vector2(0,0)
	isexploding = true
	$CatSprite.play("explode")
	await get_tree().create_timer(0.34).timeout
	$explosion.play()
	var e_instance = explosion.instantiate()
	add_child(e_instance)
	await get_tree().create_timer(0.26).timeout
	$shriek.stop()
	await get_tree().create_timer(0.4).timeout
	while not Global.ball_stopped:
		await get_tree().process_frame
	if lives == 0 and not Global.win:
		Global.lose = true
	isexploding = false
	$CollisionShape2D.disabled = false
	$Area2D/CollisionShape2D.disabled = false

func _input(event):
	if event.is_action_pressed("meow") and not isexploding:
		$meow.play()
