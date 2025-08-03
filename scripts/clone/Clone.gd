extends CharacterBody2D

class_name Clone

var load_data : Dictionary = Dictionary()
var count = 0
var is_playing = false
var playback_timer = 0.0
var play_reverse = false
@onready var ani = $AnimatedSprite2D
@onready var collision = $CollisionShape2D
@onready var AudioStreamPlayer2d : AudioStreamPlayer2D = $AudioStreamPlayer2D 

# Player crushing detection
var player_reference = null

func _ready():
	# Add clone to group so player can find it
	add_to_group("clones")
	
	# Connect to the player's recording controller signal
	var player = get_tree().get_first_node_in_group("player")
	if player and player.has_signal("recording_finished"):
		player.recording_finished.connect(_on_recording_finished)
		player_reference = player

func _on_recording_finished(recording_data: Dictionary):
	load_data = recording_data.duplicate()
	start_playback()
	

func start_playback():
	is_playing = true
	count = 0
	playback_timer = 0.0
	play_reverse = false
	AudioStreamPlayer2d.stream = load("res://assets/Music/sound/GMTK Science 2025Clone Appear_v2.wav")
	AudioStreamPlayer2d.play()
	print("Clone starting playback...")

func _physics_process(_delta):
	if is_playing:
		get_recording()


func destroy_player():
	if player_reference and is_instance_valid(player_reference):
		player_reference.queue_free()
		player_reference = null
		print("Player destroyed by clone!")

func get_recording():
	count += -1 if play_reverse else 1
	var test = load_data.get(str(count))
	if test != null:
		ani.play(test[0])
		global_position = str_to_var("Vector2" + str(test[1]))
		ani.flip_h = !test[2] if play_reverse else test[2]
	else:
		# End of recording data
		play_reverse = !play_reverse
		print("Clone playback finished, repeating steps")
	
	
