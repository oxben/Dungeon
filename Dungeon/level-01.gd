
extends Node2D

# member variables here, example:
# var a=2
# var b="textvar"

func _ready():
	set_process_input(true)

func _input(event):
	if event.is_action_released("quit_game"):
		get_tree().quit()

