extends KinematicBody2D

var speed     = 8
var direction = Vector2(0, 0)
var lifetime  = 2
var exploded  = false
var damage    = 5

func _ready():
	add_to_group("enemy")
	set_fixed_process(true)

func _fixed_process(delta):
	lifetime -= delta
	if lifetime <= 0 : #or is_colliding():
		queue_free()
	elif not exploded and is_colliding():
		if get_collider().is_in_group("enemy"):
			get_collider().hit(damage)
		exploded = true
		speed = 0
		# Prevent any further collisions
		set_collision_mask(0)
		set_layer_mask(0)
		# Explode!
		var anim = get_node("AnimationPlayer")
		lifetime = anim.get_animation("Explode").get_length()
		anim.play("Explode")
	else:
		if speed > 0:
			move((direction.normalized() * speed))
		# fireball spin even when it is exploding
		get_node("Light2D").rotate(deg2rad(360)*delta)

