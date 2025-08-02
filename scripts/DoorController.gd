extends Node2D
@onready var animatedSprite = $AnimatedSprite2D

var player_inside = false

@export var ui_win_scene_path: String = "res://scenes/UI/UiWin.tscn"
@export var level_number: int
func _ready():
	animatedSprite.play("close_idle")

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("down") && player_inside:
		print("Player activated door - loading UiWin scene")
		instantiate_ui_win()

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
		

func _on_player_entered(body):
	if body.is_in_group("player"):
		print("Player entered door area - opening door")
		open_door()

func _on_player_exited(body):
	if body.is_in_group("player"):
		print("Player exited door area - closing door")
		player_inside = false
		close_door()

func _on_animation_finished():
	match animatedSprite.animation:
		"open":
			player_inside = true
			print("Door opened - playing open_idle")
		"close":
			player_inside = false
			print("Door closed - playing idle")
		_:
			pass

func open_door():
	animatedSprite.play("open")

func close_door():
	player_inside = false
	animatedSprite.play("close")
	
	
