# Chest
extends KinematicBody2D

var open = false
var opening = false

func _ready():
	add_to_group("activable")
	set_physics_process(true)

func _physics_process(delta):
	# Set 'open' frame only once sound has finished
	# There must be a simpler and more reliable way to do this
	if opening:
		if not get_node("SfxOpen").is_playing():
			get_node("Sprite").set_frame(1)
			opening = false

func activate():
	if open:
		open = false
		get_node("SfxOpen").play()
		get_node("Sprite").set_frame(0)
	else:
		open = true
		opening = true
		get_node("SfxClose").play()
		#get_node("Sprite").set_frame(1)


