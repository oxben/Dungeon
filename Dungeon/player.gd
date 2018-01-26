extends KinematicBody2D

var speed     = 2
var direction = Vector2(0, 0)
var collision  = null

#func _ready():
#	set_physics_process(true)
#	set_process_input(true)

func _physics_process(delta):
	if direction.x != 0 or direction.y != 0:
		collision = move_and_collide((direction.normalized() * speed))
		if collision:
			pass
		#var pos = get_pos()
		#set_pos(pos + (direction.normalized() * speed)) # * delta))q
	# Scroll
	var gpos = get_global_position()
	if gpos.x < 32:
		get_parent().move_local_x(4)
	elif gpos.x > 768:
		get_parent().move_local_x(-4)
	if gpos.y < 32:
		get_parent().move_local_y(4)
	elif gpos.y > 568:
		get_parent().move_local_y(-4)

func rotate():
	var rad_angle = atan2(direction.x, -direction.y)
	set_rotation(rad_angle)

func _input(event):
	if event is InputEventKey or event is InputEventJoypadButton:
		if event.is_action_pressed("ui_left") and direction.x != -1:
			direction.x = -1
			rotate()
			get_node("Sprite").get_node("Shadow").set_position(Vector2(-2,2))
		elif event.is_action_pressed("ui_right") and direction.x != 1:
			direction.x = 1
			rotate()
			get_node("Sprite").get_node("Shadow").set_position(Vector2(2,-2))
		elif event.is_action_pressed("ui_up") and direction.y != -1:
			direction.y = -1
			rotate()
			get_node("Sprite").get_node("Shadow").set_position(Vector2(2,2))
		elif event.is_action_pressed("ui_down") and direction.y != 1:
			direction.y = 1
			rotate()
			get_node("Sprite").get_node("Shadow").set_position(Vector2(-2,-2))
		elif event.is_action_released("ui_left") or \
			event.is_action_released("ui_right"):
			direction.x = 0
			if direction.y != 0:
				rotate()
		elif event.is_action_released("ui_up") or \
			event.is_action_released("ui_down"):
			direction.y = 0
			if direction.x != 0:
				rotate()
		elif event.is_action_pressed("ui_accelerate"):
			speed = speed * 2
		elif event.is_action_released("ui_accelerate"):
			speed = speed / 2
		elif event.is_action_pressed("fire"):
			var scene = preload("res://fireball.tscn");
			var fireball = scene.instance()
			fireball.direction = Vector2(0, -1).rotated(get_rotation())
			fireball.set_global_position(get_node("FireballEmitter").get_global_position())
			get_tree().get_root().add_child(fireball)
		elif event.is_action_pressed("ui_accept"):
			if collision and collision.collider.is_in_group("activable"):
				collision.collider.activate()
