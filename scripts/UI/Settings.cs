using Godot;
using System;

public partial class Settings : Control
{
    public override void _Ready()
    {
        GetNode<Button>("/root/Settings/Settings/VBoxContainer/Back").Pressed += OnBackPressed;
    }


    private void OnBackPressed()
    {
        GD.Print("Back to Main Menu");
        GetTree().ChangeSceneToFile("res://scenes/UI/MainMenu.tscn");
    }
}
