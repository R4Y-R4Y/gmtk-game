extends CharacterBody2D

class_name Clone

var load_data : Dictionary = Dictionary()
var count = 0
var is_playing = false
var playback_timer = 0.0
var play_reverse = false
@onready var ani = $AnimatedSprite2D
@onready var collision = $CollisionShape2D

# Player crushing detection
var player_reference = null

func _ready():
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
	print("Clone starting playback...")

func _physics_process(_delta):
	if is_playing:
		get_recording()
		check_player_crushing()

func check_player_crushing():
	if player_reference == null or not is_instance_valid(player_reference):
		return
	
	var dot_product_vertical = global_position.direction_to(player_reference.global_position).dot(Vector2.RIGHT)
	var dot_product_horizontal = global_position.direction_to(player_reference.global_position).dot(Vector2.UP)

	var distance = global_position.distance_to(player_reference.global_position)
	var vector_player_clone = global_position - player_reference.global_position

	var horizontal_crush = distance < 15 and abs(dot_product_horizontal) < .22 and abs(vector_player_clone.y) < 20
	var vertical_crush = distance < 50 and abs(dot_product_vertical) < .22 and vector_player_clone.y < 0
	
	if horizontal_crush or vertical_crush or distance < 0.001:

		var space_state = get_world_2d().direct_space_state
		var query = PhysicsShapeQueryParameters2D.new()
		query.shape = collision.shape
		query.transform = global_transform
		query.collision_mask = player_reference.collision_layer
		
		var results = space_state.intersect_shape(query)
		for result in results:
			if result.collider == player_reference:
				print("Clone is crushing the player! Destroying player...")
				destroy_player()
				return

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
	
	
