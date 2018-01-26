
extends KinematicBody2D

var walk = false
var speed = 60
var direction = Vector2(1, 0)
var collision = null

func _ready():
	set_process_input(true)
	set_physics_process(true)
	# Disable collisions
	#set_collision_mask(0)
	#set_layer_mask(0)

func _physics_process(delta):
	if walk:
		if collision:
			# Change direction
			direction.x = -direction.x
			var anim = get_node("AnimationPlayer")
			if direction.x > 0:
				anim.play("WalkRight")
			else:
				anim.play("WalkLeft")
		if get_global_position().x > 736:
			direction.x = -1
		elif get_global_position().x < 32:
			direction.x = 1

		collision = move_and_collide(direction.normalized() * speed * delta)

func _input(event):
	if event is InputEventKey:
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



