extends PlatformerController2D

class_name RecordingController

var count = 0
var is_recording = false
var recording_timer = 0.0

#Our dictionary we store values too
var save_data = {"0": ["nothing",Vector2(0,0),false]}

var motion = Vector2.ZERO
var UP : Vector2 = Vector2(0,-1)

var currentClone : Clone
var selected_clone_index : int = 0

@onready var ani = $AnimatedSprite2D

##Period for recording player's actions in seconds
@export_range(1, 10) var recordingDuration: float = 3.0
@export var cloneArray: Array[Clone]

func _ready():
	super._ready()
	# Add player to group so clones can find it
	add_to_group("player")

	# Set current clone to first available, or null if none
	if cloneArray.size() > 0:
		selected_clone_index = 0
		currentClone = cloneArray[selected_clone_index]
		print("Found ", cloneArray.size(), " clones. Selected clone: ", selected_clone_index + 1)
	else:
		currentClone = null
		print("No clones found in scene")

func select_next_clone():
	selected_clone_index = (selected_clone_index + 1) % cloneArray.size()
	currentClone = cloneArray[selected_clone_index]
	print("Selected clone: ", selected_clone_index + 1, " of ", cloneArray.size())

func _physics_process(delta: float) -> void:
	super._physics_process(delta)
	
	if Input.is_action_just_pressed("select_clone"):
		select_next_clone()
	
	if Input.is_action_just_pressed("record") and not is_recording:
		start_recording()
	
	if is_recording:
		recording_timer += delta
		count += 1
		save_data[str(count)] = [ani.animation, global_position, ani.flip_h]
		
		if recording_timer >= recordingDuration:
			stop_recording()

func start_recording():
	recording_timer = 0.0
	count = 0
	save_data.clear()
	is_recording = true
	print("Recording started...")

func stop_recording():
	is_recording = false
	print("Recording finished!")
	
	# Send signal only to the currently selected clone
	if currentClone != null and is_instance_valid(currentClone):
		currentClone._on_recording_finished(save_data)
