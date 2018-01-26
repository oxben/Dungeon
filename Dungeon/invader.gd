extends KinematicBody2D

var speed = 2
var direction = Vector2(1, 1)
var health = 15
var armor = 0

func _ready():
	add_to_group("enemy")
	set_physics_process(true)

func _physics_process(delta):
	if health <= 0:
		if not get_node("AnimationPlayer").is_playing():
			queue_free()
	else:
		var collision = move_and_collide((direction.normalized() * speed))
		if collision:
			direction.x = rand_range(-1,1)
			direction.y = rand_range(-1,1)

func hit(damage):
	if health <= 0:
		# If unit is already dead (case of wrecks)
		return
	health -= max(0, damage - armor)
	if health <= 0:
		# Prevent any further collisions
		set_collision_mask_bit(0, 0)
		set_collision_layer_bit(0, 0)
		# Explode!
		get_node("AnimationPlayer").play("Explode")

