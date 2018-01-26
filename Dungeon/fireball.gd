extends KinematicBody2D

var speed     = 8
var direction = Vector2(0, 0)
var lifetime  = 2
var exploded  = false
var damage    = 5
var collision = null

func _ready():
	add_to_group("enemy")
	set_physics_process(true)

func _physics_process(delta):
	lifetime -= delta
	if lifetime <= 0 : #or is_colliding():
		queue_free()
	elif not exploded and collision:
		var collider = collision.get_collider()
		if collider.is_in_group("enemy"):
			collider.hit(damage)
		exploded = true
		speed = 0
		# Prevent any further collisions
		set_collision_mask_bit(0, 0)
		set_collision_layer_bit(0, 0)
		# Explode!
		var anim = get_node("AnimationPlayer")
		lifetime = anim.get_animation("Explode").get_length()
		anim.play("Explode")
	else:
		if speed > 0:
			collision = move_and_collide(direction.normalized() * speed)
		# fireball spin even when it is exploding
		get_node("Light2D").rotate(deg2rad(360)*delta)
