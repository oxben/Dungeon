extends TextureButton

var slot = null
var dragging = false
var mouse_pos = Vector2()
var offset = Vector2(-16, -16)

func _ready():
	pass

func _physics_process(delta):
    if dragging:
        set_global_position(mouse_pos + offset)

func _input(event):
	if event is InputEventMouseMotion and dragging:
		mouse_pos = event.get_global_position()

func _on_button_up():
	dragging = not dragging
