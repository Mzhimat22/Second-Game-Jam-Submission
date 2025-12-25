extends CanvasLayer
signal on_transition_finished

# Called when the node enters the scene tree for the first time.
func _ready():
	$ColorRect.visible = false
	$AnimationPlayer.animation_finished.connect(_on_animation_finished)

func _on_animation_finished(anim_name):
	if anim_name == "fade_in":
		on_transition_finished.emit()
		$AnimationPlayer.play("fade_out")
	elif anim_name == "fade_out":
		$ColorRect.visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func transition():
	$ColorRect.visible = true
	$AnimationPlayer.play("fade_in")
