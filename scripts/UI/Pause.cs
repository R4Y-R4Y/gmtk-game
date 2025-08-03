using Godot;
using System;

public partial class Pause : CanvasLayer
{
	private CanvasLayer pauseMenu;

	public override void _Ready()
	{
		pauseMenu = GetNode<CanvasLayer>("PauseMenu");
		pauseMenu.Visible = false;
	}

	public override void _Process(double delta)
	{
		if (Input.IsActionJustPressed("ui_cancel"))
		{
			TogglePauseMenu();
		}
	}

	private void TogglePauseMenu()
	{
		bool isPaused = !pauseMenu.Visible;
		pauseMenu.Visible = isPaused;
		GetTree().Paused = isPaused;

		pauseMenu.ProcessMode = Node.ProcessModeEnum.Always;
	}

	public void OnResumePressed()
	{
		pauseMenu.Visible = false;
		GetTree().Paused = false;
	}

	public void OnRestartPressed()
	{
		GetTree().Paused = false;
		GetTree().ReloadCurrentScene();
	}

	public void OnBackPressed()
	{
		GetTree().Paused = false;
		GetTree().ChangeSceneToFile("res://scenes/UI/MainMenu.tscn");
	}
}
