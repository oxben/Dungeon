
extends KinematicBody2D

var walk = false
var speed = 60
var direction = Vector2(1, 0)

func _ready():
	set_process_input(true)
	set_fixed_process(true)
	# Disable collisions
	#set_collision_mask(0)
	#set_layer_mask(0)

func _fixed_process(delta):
	if walk:
		if is_colliding():
			# Change direction
			direction.x = -direction.x
			var anim = get_node("AnimationPlayer")
			if direction.x > 0:
				anim.play("WalkRight")
			else:
				anim.play("WalkLeft")
		if get_global_pos().x > 736:
			direction.x = -1
		elif get_global_pos().x < 32:
			direction.x = 1

		move((direction.normalized() * speed * delta))

func _input(event):
	if event.type == InputEvent.KEY:
		print(event)
		if event.is_pressed() and event.scancode == KEY_W:
			var anim = get_node("AnimationPlayer")
			if not walk:
				walk = true
				if direction.x > 0:
					anim.play("WalkRight")
				else:
					anim.play("WalkLeft")
			else:
				walk = false
				anim.stop()



