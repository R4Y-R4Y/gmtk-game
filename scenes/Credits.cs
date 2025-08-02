using Godot;
using System;

public partial class Credits : Control
{
    public override void _Ready()
    {
        GetNode<Button>("/root/Credits/Credits/VBoxContainer/Back").Pressed += OnBackPressed;
    }


    private void OnBackPressed()
    {
        GD.Print("Back to Main Menu");
        GetTree().ChangeSceneToFile("res://scenes/MainMenu.tscn");
    }
}
