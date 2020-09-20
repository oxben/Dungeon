# Game
extends Node2D

var global = null

# Current level
var level_name = ""
var level = null

var char_sheet_visible = false
var inventory = null
var body = null


func _ready():
	global = get_node("/root/global")
	# Add level scene to current scene
	if level_name == "":
		level_name = "level-01"
	var scn = ResourceLoader.load("res://" + level_name + ".tscn")
	level = scn.instance()
	add_child(level)
	move_child(level, 0)
	set_process_input(true)
	inventory = get_node("CharacterSheetPanel/TabContainer/Inventory/VBoxContainer/InventoryScroll/TextureRect")
	body = get_node("CharacterSheetPanel/TabContainer/Inventory/VBoxContainer/BodyPanel")
	test_inventory()


func _input(event):
	if event.is_action_released("quit_game"):
		get_tree().quit()
	if event.is_action_released("show_char_sheet"):
		if not char_sheet_visible:
			get_node("AnimationPlayer").play("ShowCharSheet")
		else:
			get_node("AnimationPlayer").play("HideCharSheet")
		char_sheet_visible = not char_sheet_visible


func test_inventory():
	var scene = load("res://inventory-object.tscn")
	var object = scene.instance()
	var texture = load("res://assets/gfx/red-potion.png")
	object.set_normal_texture(texture)
	inventory.get_node("Slot-1x1").add_child(object)
	object = scene.instance()
	texture = load("res://assets/gfx/objects/long-sword-poison-2.png")
	object.set_normal_texture(texture)
	body.get_node("SlotRightArm").add_child(object)
	
