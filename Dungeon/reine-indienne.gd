extends KinematicBody2D

var speed = 2
var direction = Vector2(1, 1)

func _ready():
	set_fixed_process(true)

func _fixed_process(delta):
	if is_colliding():
		direction.x = rand_range(-1,1)
		direction.y = rand_range(-1,1)
	move((direction.normalized() * speed))
