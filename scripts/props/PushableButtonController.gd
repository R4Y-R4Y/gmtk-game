extends Node

signal button_pressed
signal button_released


@onready var button_area: Area2D = $Area2D
@onready var animated_sprite: AnimationPlayer = $AnimationPlayer

var clone_in_zone
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
	# Check if there are still any player or clone bodies in the area
	var overlapping_bodies = button_area.get_overlapping_bodies()
	var still_has_valid_bodies = false

	for overlapping_body in overlapping_bodies:
		if overlapping_body.is_in_group("player") or overlapping_body.is_in_group("clones"):
			print( "Clone" if overlapping_body.is_in_group("player") else "Player" + "still on button")
			return

	# Only release the button if no valid bodies are still on it
	if not still_has_valid_bodies and is_pressed:
		print("Button released!")
		animated_sprite.play("release")
		button_released.emit()
	is_pressed = false

func press_button():
	is_pressed = true
	animated_sprite.play("press")
	button_pressed.emit()
	print("Button pressed!")
