extends HBoxContainer
@onready var nb_max_clones = get_node("/root/Node2D/Player").cloneArray.size()
@onready var clones_container = $"."  # Reference to self since this script extends HBoxContainer
@export var clone_texture: Texture2D

func _ready():
	print(nb_max_clones)
	for i in range(nb_max_clones):
		print(i)
		print(clone_texture)
		var clone = Sprite2D.new()
		clone.texture = clone_texture
		clone.position = Vector2(i * 100, 0)  
		clone.scale = Vector2(2, 2) 
		clones_container.add_child(clone)
