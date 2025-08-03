using Godot;
using System;

public partial class LevelSelection : Control
{
	public override void _Ready()
	{
		for (int i = 1; i <= 12; i++)
		{
			var levelButton = GetNode<Button>($"LevelGrid/Level{i}Container/Level{i}");
			int levelNumber = i; 
			levelButton.Pressed += () => OnLevelPressed(levelNumber);
		}
		
		// Connect back button
		GetNode<Button>("BackButton").Pressed += OnBackPressed;
	}

	private void OnLevelPressed(int levelNumber)
	{
		GD.Print($"Loading Level {levelNumber}");
		GetTree().ChangeSceneToFile($"res://scenes/levels/level{levelNumber}.tscn");
	}

	private void OnBackPressed()
	{
		GD.Print("Going back to Main Menu");
		GetTree().ChangeSceneToFile("res://scenes/UI/MainMenu.tscn");
	}
}
