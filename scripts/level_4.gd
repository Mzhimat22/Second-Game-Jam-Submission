extends Node2D
var velocity = Vector2(0,-1)
var speed = 1000
var go = false
var slide = true
var plat_v = -1
var plat_v2 = -1
var plat_v3 = -1
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
		$DeathScreen/Button.text = "Back to the\nmain menu"
		var temp = ""
		if Global.star:
			temp = "\nWow, you won without\nrestarts! Good job!"
		slide_pop(Global.holeinone+"Thank you for playing,\nladdie!"+temp)
		Global.hard_mode_disabled = false
	elif Global.lose and slide:
		slide = false
		$lose.play()
		$DeathScreen/Button.text = "Back to the\nstart"
		slide_pop("You ran out of lives...")
		
	if go:
		$DeathScreen.global_position += speed * velocity * delta
	
	if $platform.global_position.y < -110 or $platform.global_position.y > 210:
		plat_v *= -1
	if $platform2.global_position.y < -110 or $platform2.global_position.y > 210:
		plat_v2 *= -1
	if $platform3.global_position.y < -110 or $platform3.global_position.y > 210:
		plat_v3 *= -1
	
	$platform.global_position.y += 100*plat_v*delta
	$platform2.global_position.y += 250*plat_v2*delta
	$platform3.global_position.y += 500*plat_v3*delta

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
	if $DeathScreen/Button.text == "Back to the\nmain menu":
		get_tree().change_scene_to_file("res://scenes/mainmenu.tscn")
	elif $DeathScreen/Button.text == "Back to the\nstart":
		Global.lives = 9
		Global.starting_lives = 9
		Global.star = true
		get_tree().change_scene_to_file("res://scenes/mainmenu.tscn")
