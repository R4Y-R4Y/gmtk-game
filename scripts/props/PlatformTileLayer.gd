extends TileMapLayer

# Platform state
var is_platform_enabled: bool = true
var cells: Array[Vector2i]
@export var platform_enabled: bool = true  # The ID of your terrain set in the TileSet

func _ready():
	cells = get_used_cells()
	set_cells_terrain_connect(cells, 0, 0 if platform_enabled else 1)
	
func enable():
	set_cells_terrain_connect(cells, 0, 0)
	return
	
func disable():
	set_cells_terrain_connect(cells, 0, 1)
	return


func _on_pushable_button_button_pressed() -> void:
	pass # Replace with function body.


func disabel() -> void:
	pass # Replace with function body.
