extends Node

@onready var continue_button = %ContinueButton
@onready var loading_label = %LoadingLabel
@onready var loading_sprite = %LoadingSprite

var main_scene_path = "res://scenes/intro.tscn"
var scene_load_status = 0
var main_scene: PackedScene

func _ready():
	continue_button.pressed.connect(func(): get_tree().change_scene_to_packed(main_scene))
	ResourceLoader.load_threaded_request(main_scene_path)

func _process(_delta: float):
	scene_load_status = ResourceLoader.load_threaded_get_status(main_scene_path)
	if scene_load_status == ResourceLoader.THREAD_LOAD_LOADED:
		main_scene = ResourceLoader.load_threaded_get(main_scene_path)
		await get_tree().create_timer(1).timeout
		loading_label.visible = false
		continue_button.visible = true
		loading_sprite.visible = false
