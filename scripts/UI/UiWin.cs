using Godot;

public partial class UiWin : CanvasLayer
{
    [Export]
    public int Number { get; set; } = 1;
    private CanvasLayer winMenu;

    public void OnRestartPressed()
    {
        GetTree().ReloadCurrentScene();
    }

    public void OnNextLevelPressed()
    {
        GetTree().ChangeSceneToFile($"res://scenes/levels/level{Number}.tscn");
    }

    public void OnMainMenuPressed()
    {
        GetTree().ChangeSceneToFile("res://scenes/UI/MainMenu.tscn");
    }
}
