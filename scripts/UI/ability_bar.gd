extends CanvasLayer

@onready var textured_progress_bar = $TextureProgressBar
var timer = 100.0
var is_depleting = false
var depletion_rate = 100.0 / Constants.RECORDING_DURATION 

func _ready():
	textured_progress_bar.value = timer
	print(depletion_rate) 

func _process(delta):	
	if Input.is_action_pressed("record") && !is_depleting:  
		is_depleting = true
	
	if is_depleting and timer > 0:
		timer -= depletion_rate * delta
		if timer <= 0:
			is_depleting = false
			timer = 100.0  
	
	textured_progress_bar.value = timer
