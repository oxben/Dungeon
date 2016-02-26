# Game
extends Node2D

var global = null

# Current level
var level_name = ""
var level = null

func _ready():
	global = get_node("/root/global")
	# Add level scene to current scene
	if level_name == "":
		level_name = "level-01"
	var scn = ResourceLoader.load("res://" + level_name + ".xscn")
	level = scn.instance()
	add_child(level)
	move_child(level, 0)
	set_process_input(true)


func _input(event):
	if event.is_action_released("quit_game"):
		get_tree().quit()


