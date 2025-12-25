extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	Music._play_music()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$"Hard Mode".disabled = Global.hard_mode_disabled


func _on_start_button_pressed():
	Global.lives = 9
	Global.starting_lives = 9
	Global.star = true
	Transition.transition()
	await Transition.on_transition_finished
	get_tree().change_scene_to_file("res://scenes/level_0.tscn")


func _on_credits_pressed():
	get_tree().change_scene_to_file("res://scenes/credits.tscn")


func _on_hard_mode_pressed():
	Global.lives = 9
	Global.starting_lives = 9
	Global.star = true
	Transition.transition()
	await Transition.on_transition_finished
	get_tree().change_scene_to_file("res://scenes/level_0.tscn")
