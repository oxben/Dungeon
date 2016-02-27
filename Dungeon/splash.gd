# Splash Screen
extends Control

var selection = -1
var button_list = ["Start", "Quit"]

func _ready():
	print("Splash ready!")
	set_process_input(true)
	
func _input(event):
	if event.type in [InputEvent.KEY, InputEvent.JOYSTICK_BUTTON]:
		var inc = 0
		if event.is_action_pressed("ui_up"):
			inc = -1
		elif event.is_action_pressed("ui_down"):
			inc = 1
		if selection >= 0:
			# warning result of '%' in GDScript as same sign as dividend.
			# Could be a negative value here
			selection = abs((selection + inc) % button_list.size())
		else:
			if inc == 1:
				selection = 0
			else:
				selection = button_list.size()-1
		get_node(button_list[selection]).grab_focus()

func _on_Start_pressed():
	print("Load level")
	get_node("/root/global").goto_scene("res://game.xscn", "level-01")


func _on_Quit_pressed():
	get_tree().quit()
