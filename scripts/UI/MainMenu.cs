using Godot;
using System;

public partial class MainMenu : Control
{
    public override void _Ready()
    {
        GetNode<Button>("/root/MainMenu/MainMenu/VBoxContainer/New Game").Pressed += OnStartPressed;
        GetNode<Button>("/root/MainMenu/MainMenu/VBoxContainer/Load Game").Pressed += OnLoadPressed;
        GetNode<Button>("/root/MainMenu/MainMenu/VBoxContainer/Settings").Pressed += OnSettingsPressed;
        GetNode<Button>("/root/MainMenu/MainMenu/VBoxContainer/Credits").Pressed += OnCreditsPressed;
        GetNode<Button>("/root/MainMenu/MainMenu/VBoxContainer/Exit").Pressed += OnExitPressed;
    }

    private void OnStartPressed()
    {
        GD.Print("Start Game");
        GetTree().ChangeSceneToFile("res://scenes/Main.tscn");
    }

    private void OnLoadPressed()
    {
        GD.Print("Start Game");
        GetTree().ChangeSceneToFile("res://scenes/Main.tscn");
    }

    private void OnSettingsPressed()
    {
        GD.Print("Settings ⚙️");
        GetTree().ChangeSceneToFile("res://scenes/UI/Settings.tscn");
    }

    private void OnCreditsPressed()
    {
        GD.Print("Credits");
        GetTree().ChangeSceneToFile("res://scenes/UI/Credits.tscn");
    }

    private void OnExitPressed()
    {
        GD.Print("Exiting Game 🚀");
        GetTree().Quit();
    }
}
