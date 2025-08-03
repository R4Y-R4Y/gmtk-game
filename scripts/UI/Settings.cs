using Godot;

public partial class Settings : Control
{
    private HSlider _musicSlider;
    private Label _musicValueLabel;

    public override void _Ready()
    {
        GetNode<Button>("BackButton").Pressed += OnBackPressed;
        _musicSlider = GetNode<HSlider>("SettingsContainer/AudioSection/MusicSlider");
        _musicValueLabel = GetNode<Label>("SettingsContainer/AudioSection/MusicValueLabel");
        
        _musicSlider.Value = 100;
        UpdateMusicVolumeLabel();
        
        _musicSlider.ValueChanged += OnMusicVolumeChanged;
    }

    private void OnMusicVolumeChanged(double value)
    {
        var musicBusIndex = AudioServer.GetBusIndex("Master");
        AudioServer.SetBusVolumeDb(musicBusIndex, Mathf.LinearToDb((float)value / 100.0f));
        
        UpdateMusicVolumeLabel();
    }

    private void UpdateMusicVolumeLabel()
    {
        _musicValueLabel.Text = $"{(int)_musicSlider.Value}%";
    }

    private void OnBackPressed()
    {
        GD.Print("Back to Main Menu");
        GetTree().ChangeSceneToFile("res://scenes/UI/MainMenu.tscn");
    }
}
