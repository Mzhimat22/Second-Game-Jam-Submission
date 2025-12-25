extends Node

var ball_stopped = false
var win = false
var lose = false
var holeinone = "\n"
var lives = 9
var starting_lives = 9
var star
var hard_mode_disabled = true

func _input(event):
	if event.is_action_pressed("ui_cancel"):
			get_tree().quit()
