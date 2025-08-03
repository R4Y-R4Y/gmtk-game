using Godot;
using System;

public partial class MainMenu : Control
{
    public override void _Ready()
    {
        CreateParticleTexture();
        
        GetNode<Button>("/root/MainMenu/MainMenu/StartNewGame").Pressed += OnStartPressed;
        GetNode<Button>("/root/MainMenu/MainMenu/LoadGame").Pressed += OnLoadPressed;
        GetNode<Button>("/root/MainMenu/MainMenu/Settings").Pressed += OnSettingsPressed;
        GetNode<Button>("/root/MainMenu/MainMenu/Credits").Pressed += OnCreditsPressed;
        GetNode<Button>("/root/MainMenu/MainMenu/Exit").Pressed += OnExitPressed;
    }

    private void CreateParticleTexture()
    {
        var image = Image.CreateEmpty(16, 16, false, Image.Format.Rgba8);
        
        for (int x = 0; x < 16; x++)
        {
            for (int y = 0; y < 16; y++)
            {
                float distance = Vector2.Zero.DistanceTo(new Vector2(x - 8, y - 8));
                if (distance <= 7)
                {
                    float alpha = 1.0f - (distance / 7.0f);
                    image.SetPixel(x, y, new Color(1, 1, 1, alpha));
                }
                else
                {
                    image.SetPixel(x, y, new Color(0, 0, 0, 0));
                }
            }
        }
        
        var texture = ImageTexture.CreateFromImage(image);
        
        var particles = GetNode<GpuParticles2D>("BackgroundParticles");
        particles.Texture = texture;
    }

    private void OnStartPressed()
    {
        GD.Print("Start Game - Loading Story");
        GetTree().ChangeSceneToFile("res://scenes/UI/Story.tscn");
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
