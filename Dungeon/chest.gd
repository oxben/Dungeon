# Chest
extends KinematicBody2D

var open = false
var opening = false

func _ready():
	add_to_group("activable")
	set_fixed_process(true)

func _fixed_process(delta):
	# Set 'open' frame only once sound has finished
	# There must be a simpler and more reliable way to do this
	if opening:
		if not get_node("SamplePlayer").is_active():
			get_node("Sprite").set_frame(1)
			opening = false
		
func activate():
	if open:
		open = false
		get_node("SamplePlayer").play("chest-close")
		get_node("Sprite").set_frame(0)
	else:
		open = true
		opening = true
		get_node("SamplePlayer").play("chest-open")
		#get_node("Sprite").set_frame(1)


