extends Node2D
var velocity = Vector2(0,-1)
var speed = 1000
var go = false
var slide = true

# Called when the node enters the scene tree for the first time.
func _ready():
	Global.lives = Global.starting_lives
	Global.win = false
	Global.lose = false
	Global.holeinone = "You achieved a hole in one!\n"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Camera2D/Label.text = "Lives: "+str($Player.lives)
	if Global.win and slide:
		slide = false
		$win.play()
		$DeathScreen/Button.text = "Next Level"
		slide_pop(Global.holeinone+"You won!")
	elif Global.lose and slide:
		slide = false
		$lose.play()
		$DeathScreen/Button.text = "Back to the\nstart"
		slide_pop("You ran out of lives...")
		
	if go:
		$DeathScreen.global_position += speed * velocity * delta

func slide_pop(i):
	Global.ball_stopped = true
	$DeathScreen/Label.text = i
	$Timer.start()
	go = true


func _input(event):
	if event.is_action_pressed("restart") and not Global.win and not Global.lose:
		Transition.transition()
		await Transition.on_transition_finished
		Global.lives = Global.starting_lives
		Global.ball_stopped = true
		Global.star = false
		get_tree().reload_current_scene()


func _on_timer_timeout():
	go = false


func _on_button_pressed():
	Transition.transition()
	await Transition.on_transition_finished
	if $DeathScreen/Button.text == "Next Level":
		get_tree().change_scene_to_file("res://scenes/level_4.tscn")
	elif $DeathScreen/Button.text == "Back to the\nstart":
		Global.lives = 9
		Global.starting_lives = 9
		Global.star = true
		get_tree().change_scene_to_file("res://scenes/mainmenu.tscn")
