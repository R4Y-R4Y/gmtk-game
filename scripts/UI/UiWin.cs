using Godot;

public partial class UiWin : CanvasLayer
{
    [Export]
    public int Number { get; set; } = 1;
    private CanvasLayer winMenu;

    public void OnRestartPressed()
    {
        GetTree().Paused = false;
        GetTree().ReloadCurrentScene();
    }

    public void OnNextLevelPressed()
    {
        GetTree().Paused = false;
        GetTree().ChangeSceneToFile($"res://scenes/levels/level{Number}.tscn");
    }

    public void OnMainMenuPressed()
    {
        GetTree().Paused = false;
        var audioPlayer = GetNode<AudioStreamPlayer2D>("/root/BackgroundMusicPlayer");
		audioPlayer.Stream = GD.Load<AudioStream>("res://assets/Music/Theme/gmtkmenu25_v2.wav");
		audioPlayer.Play();
        GetTree().ChangeSceneToFile("res://scenes/UI/MainMenu.tscn");
    }
}
