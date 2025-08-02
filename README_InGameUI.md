# InGameUI Usage Guide

## Overview
The InGameUI scene provides a pause menu system that can be added to any level in your game. It includes Resume, Restart, and Back to Main Menu functionality.

## Files
- **Scene**: `res://scenes/UI/ingameui.tscn`
- **Script**: `res://scripts/UI/Pause.cs`

## Features
- **Pause/Resume**: Press Escape (ui_cancel) to toggle pause menu
- **Resume Button**: Continues the current game
- **Restart Button**: Reloads the current scene from the beginning
- **Back Button**: Returns to the main menu

## How to Add to Your Levels

### Method 1: Direct Instance (Recommended)
Add the InGameUI scene as a child of your level's root node:

```gdscript
[node name="YourLevel" type="Node2D"]

[node name="InGameUI" parent="." instance=ExtResource("path_to_ingameui")]
```

### Method 2: Template Usage
Use the provided `LevelTemplate.tscn` as a starting point for new levels.

## Implementation Examples

### Main.tscn
```gdscript
[node name="Node2D" type="Node2D"]

[node name="Player" parent="." instance=ExtResource("player_scene")]
[node name="TileMapLayer" parent="." instance=ExtResource("level_scene")]
[node name="InGameUI" parent="." instance=ExtResource("ingameui_scene")]
```

### Individual Level
```gdscript
[node name="Level2" type="Node2D"]

[node name="InGameUI" parent="." instance=ExtResource("ingameui_scene")]
```

## Script Reference

### Pause.cs Methods
- `TogglePauseMenu()`: Shows/hides pause menu and pauses/unpauses game
- `OnResumePressed()`: Resume game functionality
- `OnRestartPressed()`: Restart level functionality  
- `OnBackPressed()`: Return to main menu functionality

### Input Actions
- `ui_cancel`: Toggles pause menu (typically mapped to Escape key)

## Notes
- The pause menu automatically handles process modes to work correctly when the game is paused
- The script inherits from `CanvasLayer` to ensure UI elements appear above game content
- All button connections are set up in the scene file automatically
