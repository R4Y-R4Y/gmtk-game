extends Node

signal button_pressed


@onready var button_area: Area2D = $Area2D
@onready var animated_sprite: AnimationPlayer = $AnimationPlayer

@export var signal_name: String

var is_pressed: bool = false
var bodies_on_button: Array = []
var reset_timer: float = 0.0

func _ready():
	animated_sprite.play("release")

func _on_body_entered(body):
	if body.is_in_group("player") or body.is_in_group("clones"):
		if not is_pressed:
			press_button()

func _on_body_exited(body):
	print("Button released!")
	animated_sprite.play("release")
	is_pressed = false

func press_button():
	is_pressed = true
	animated_sprite.play("press")
	button_pressed.emit()
	print("Button pressed!")
