extends KinematicBody2D

var speed = 2
var direction = Vector2(1, 1)

func _ready():
	set_physics_process(true)

func _physics_process(delta):
	var collision = move_and_collide((direction.normalized() * speed))
	if collision:
		direction.x = rand_range(-1,1)
		direction.y = rand_range(-1,1)
	
