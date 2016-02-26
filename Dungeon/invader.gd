extends KinematicBody2D

var speed = 2
var direction = Vector2(1, 1)
var health = 15
var armor = 0

func _ready():
	add_to_group("enemy")
	set_fixed_process(true)

func _fixed_process(delta):
	if health <= 0:
		if not get_node("AnimationPlayer").is_playing():
			queue_free()
	elif is_colliding():
		direction.x = rand_range(-1,1)
		direction.y = rand_range(-1,1)
	move((direction.normalized() * speed))

func hit(damage):
	if health <= 0:
		# If unit is already dead (case of wrecks)
		return
	health -= max(0, damage - armor)
	if health <= 0:
		# Prevent any further collisions
		set_collision_mask(0)
		set_layer_mask(0)
		# Explode!
		get_node("AnimationPlayer").play("Explode")
		
