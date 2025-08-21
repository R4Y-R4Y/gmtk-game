extends Node2D
@onready var animatedSprite = $AnimatedSprite2D
@onready var exitArea = $ExitArea

@export var ui_win_scene_path: String = "res://scenes/UI/UiWin.tscn"
@export var door_enabled : bool
@export var level_number: int
@onready var AudioStreamPlayer2d : AudioStreamPlayer2D = $AudioStreamPlayer2D 

var player_inside = false
var player_won = false
func _ready():
	if door_enabled: 
		AudioStreamPlayer2d.stream = load("res://assets/Music/sound/GMTK Science 2025Door Open_v2.wav")
		AudioStreamPlayer2d.play()
		animatedSprite.play("open")
	else:
		animatedSprite.play("close_idle")

func _enable_door():
	open_door()
	
func _disable_door():
	close_door()

func _on_player_entered(body):
	if body.is_in_group("player") && door_enabled:
		instantiate_ui_win()
		door_enabled = false
	elif body.is_in_group("player"):
		player_inside = true

func _on_player_exited(body):
	if body.is_in_group("player"):
		player_inside = false

func open_door():
	door_enabled = true
	AudioStreamPlayer2d.stream = load("res://assets/Music/sound/GMTK Science 2025Door Open_v2.wav")
	AudioStreamPlayer2d.play()
	animatedSprite.play("open")
	if (player_inside && door_enabled):
		instantiate_ui_win()

func close_door():
	door_enabled = false
	AudioStreamPlayer2d.stream = load("res://assets/Music/sound/GMTK Science 2025Door Close_v2.wav")
	AudioStreamPlayer2d.play()
	animatedSprite.play("close")
	
func instantiate_ui_win():
	var scene_exist = ResourceLoader.exists(ui_win_scene_path)
	if scene_exist && !player_won:
		player_won = true
		get_tree().paused = true
		var ui_win_scene = load(ui_win_scene_path)
		var ui_win_instance = ui_win_scene.instantiate()
		ui_win_instance.Number = level_number
		get_tree().current_scene.add_child(ui_win_instance)
		print("UiWin scene instantiated")
	else:
		if !scene_exist:
			print("UiWin scene not found at: ", ui_win_scene_path)
			print("Please create the UiWin scene in the UI folder")
