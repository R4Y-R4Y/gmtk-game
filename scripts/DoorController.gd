extends Node2D
@onready var animatedSprite = $AnimatedSprite2D
@onready var exitArea = $ExitArea

@export var ui_win_scene_path: String = "res://scenes/UI/UiWin.tscn"
@export var door_enabled : bool
@export var level_number: int

var player_inside = false

func _ready():
	if door_enabled: 
		animatedSprite.play("open")
	else:
		animatedSprite.play("close_idle")


func _enable_door():
	open_door()
	
func _disable_door():
	close_door()

func _process(delta: float) -> void:
	if door_enabled:
		var overlapping_bodies = exitArea.get_overlapping_bodies()
		for body in overlapping_bodies:
			if body.is_in_group("player"):
				instantiate_ui_win()

func _on_player_exited(body):
	if body.is_in_group("player"):
		player_inside = false

func open_door():
	door_enabled = true
	animatedSprite.play("open")

func close_door():
	door_enabled = false
	animatedSprite.play("close")
	
func instantiate_ui_win():
	if ResourceLoader.exists(ui_win_scene_path):
		var ui_win_scene = load(ui_win_scene_path)
		var ui_win_instance = ui_win_scene.instantiate()
		ui_win_instance.Number = level_number
		get_tree().current_scene.add_child(ui_win_instance)
		print("UiWin scene instantiated")
	else:
		print("UiWin scene not found at: ", ui_win_scene_path)
		print("Please create the UiWin scene in the UI folder")
