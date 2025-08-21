extends HBoxContainer
@onready var nb_max_clones = get_node("/root/Node2D/Player").cloneArray.size()
@onready var clones_container = $"."  # Reference to self since this script extends HBoxContainer
@export var clone_texture: Texture2D
@export var selected_clone_texture: Texture2D

var current_selected = 0
func _ready():
	print(nb_max_clones)
	for i in range(nb_max_clones):
		var clone = Sprite2D.new()
		clone.texture = selected_clone_texture if i == 0 else clone_texture
		clone.position = Vector2(i * 100, 0)  
		clone.scale = Vector2(2, 2) 
		clones_container.add_child(clone)

func _process(_delta):
	if Input.is_action_just_pressed("select_clone"):
		clones_container.get_child(current_selected).texture = clone_texture
		current_selected = (current_selected + 1) % nb_max_clones
		clones_container.get_child(current_selected).texture = selected_clone_texture
		
