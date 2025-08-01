extends PlatformerController2D

class_name RecordingController

# Signal to notify clones when recording is complete
signal recording_finished(recording_data: Dictionary)

var count = 0
var is_recording = false
var recording_timer = 0.0

#Our dictionary we store values too
var save_data = {"0": ["nothing",Vector2(0,0),false]}

var motion = Vector2.ZERO
var UP : Vector2 = Vector2(0,-1)

var currentClone : Clone
@onready var ani = $AnimatedSprite2D

##Period for recording player's actions in seconds
@export_range(1, 10) var recordingDuration: float = 3.0

func _ready():
	super._ready()
	# Add player to group so clones can find it
	add_to_group("player")

func _physics_process(delta: float) -> void:
	super._physics_process(delta)
	
	if Input.is_action_just_pressed("record") and not is_recording:
		start_recording()
	
	if is_recording:
		recording_timer += delta
		count += 1
		save_data[str(count)] = [ani.animation, global_position, ani.flip_h]
		
		# Stop recording after the duration
		if recording_timer >= recordingDuration:
			stop_recording()

func start_recording():
	is_recording = true
	recording_timer = 0.0
	count = 0
	save_data.clear()
	print("Recording started...")

func stop_recording():
	is_recording = false
	print("Recording finished! Sending data to clone...")
	recording_finished.emit(save_data)
	
	# Reset for next recording
	recording_timer = 0.0
