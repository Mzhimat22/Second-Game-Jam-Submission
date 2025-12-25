extends CanvasLayer

var in_time: float = 0.5
var fade_in_time = 1.5
var pause_time = 1.5
var fade_out_time = 1.5
var out_time = 0.5

# Called when the node enters the scene tree for the first time.
func _ready():
	fade()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func fade():
	$Label.modulate.a=0.0
	$Label2.modulate.a=0.0
	$Sprite2D.modulate.a=0.0
	var tween = self.create_tween()
	var tween2 = self.create_tween()
	var tween3 = self.create_tween()
	tween.tween_interval(in_time)
	tween2.tween_interval(in_time)
	tween3.tween_interval(in_time)
	tween.tween_property($Label, "modulate:a", 1.0, fade_in_time)
	tween2.tween_property($Label2, "modulate:a", 1.0, fade_in_time)
	tween3.tween_property($Sprite2D, "modulate:a", 1.0, fade_in_time)
	tween.tween_interval(pause_time)
	tween2.tween_interval(pause_time)
	tween3.tween_interval(pause_time)
	tween.tween_property($Label, "modulate:a", 0.0, fade_out_time)
	tween2.tween_property($Label2, "modulate:a", 0.0, fade_out_time)
	tween3.tween_property($Sprite2D, "modulate:a", 0.0, fade_out_time)
	tween.tween_interval(out_time)
	tween2.tween_interval(out_time)
	tween3.tween_interval(out_time)
	await tween.finished
	await tween2.finished
	await tween3.finished
	Transition.transition()
	await Transition.on_transition_finished
	get_tree().change_scene_to_file("res://scenes/mainmenu.tscn")
