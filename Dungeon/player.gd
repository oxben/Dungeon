
extends KinematicBody2D

var speed     = 2
var direction = Vector2(0, 0)

func _ready():
	set_fixed_process(true)
	set_process_input(true)

func _fixed_process(delta):
	if direction.x != 0 or direction.y != 0:
		move((direction.normalized() * speed))
		#var pos = get_pos()
		#set_pos(pos + (direction.normalized() * speed)) # * delta))
		
func _input(event):
	if event.type in [InputEvent.KEY, InputEvent.JOYSTICK_BUTTON]:
		print(event)
		var rad_angle
		if event.is_action_pressed("ui_left") and direction.x != -1:
			direction.x = -1
			rad_angle = atan2(direction.x, direction.y) - atan2(0, -1)
			set_rot(rad_angle)
			get_node("Sprite").get_node("Shadow").set_pos(Vector2(-2,2))
		elif event.is_action_pressed("ui_right") and direction.x != 1:
			direction.x = 1
			rad_angle = atan2(direction.x, direction.y) - atan2(0, -1)
			set_rot(rad_angle)
			get_node("Sprite").get_node("Shadow").set_pos(Vector2(2,-2))
		elif event.is_action_pressed("ui_up") and direction.y != -1:
			direction.y = -1
			rad_angle = atan2(direction.x, direction.y) - atan2(0, -1)
			set_rot(rad_angle)
			get_node("Sprite").get_node("Shadow").set_pos(Vector2(2,2))
		elif event.is_action_pressed("ui_down") and direction.y != 1:
			direction.y = 1
			rad_angle = atan2(direction.x, direction.y) - atan2(0, -1)
			set_rot(rad_angle)
			get_node("Sprite").get_node("Shadow").set_pos(Vector2(-2,-2))
		elif event.is_action_released("ui_left") or \
			event.is_action_released("ui_right"):
			direction.x = 0
			if direction.y != 0:
				rad_angle = atan2(direction.x, direction.y) - atan2(0, -1)
				set_rot(rad_angle)
		elif event.is_action_released("ui_up") or \
			event.is_action_released("ui_down"):
			direction.y = 0
			if direction.x != 0:
				rad_angle = atan2(direction.x, direction.y) - atan2(0, -1)
				set_rot(rad_angle)
		elif event.is_action_pressed("ui_accelerate"):
			speed = speed * 2
		elif event.is_action_released("ui_accelerate"):
			speed = speed / 2
		elif event.is_action_pressed("fire"):
			var scene = preload("res://fireball.xscn");
			var fireball = scene.instance()
			fireball.direction = Vector2(0, -1).rotated(get_rot())
			fireball.set_global_pos(get_node("FireballEmitter").get_global_pos())
			get_tree().get_root().add_child(fireball)



