using Godot;
using System.Collections.Generic;

public partial class Credits : Control
{
    private VBoxContainer _creditsContainer;

    private readonly Dictionary<string, string[]> _creditsData = new()
    {
        { "🎮 Level Design 🎮", new[] { "Curio, Miro, Fluff, XtraByte, LuizMiguel3D" } },
        { "👨‍💻 Game Developers 👨‍💻", new[] { "Curio, Miro, Fluff" } },
        { "👾 Game Design / Pixel Art 👾", new[] { "XtraByte" } },
        { "🖥️ UI Developers 🖥️", new[] { "Fluff, Miro" } },
        { "🎵 Music and Sound Effects 🎵", new[] { "MalakaZam" } }
    };


    public override void _Ready()
    {
        GetNode<Button>("BackButton").Pressed += OnBackPressed;
        _creditsContainer = GetNode<VBoxContainer>("CreditsContainer");
        
        CreateCreditsLabels();
    }

    private void CreateCreditsLabels()
    {
        var categoryColors = new Color[]
        {
            new Color(1.0f, 0.6f, 0.8f), 
            new Color(0.6f, 1.0f, 0.7f), 
            new Color(0.8f, 0.7f, 1.0f), 
            new Color(1.0f, 0.9f, 0.5f), 
            new Color(0.5f, 0.8f, 1.0f)  
        };
        
        int colorIndex = 0;
        
        foreach (var category in _creditsData)
        {
            var categoryLabel = new Label
            {
                Text = category.Key,
                HorizontalAlignment = HorizontalAlignment.Center,
                Modulate = categoryColors[colorIndex % categoryColors.Length]
            };
            categoryLabel.AddThemeFontSizeOverride("font_size", 48);
            _creditsContainer.AddChild(categoryLabel);

            foreach (var person in category.Value)
            {
                var personLabel = new Label
                {
                    Text = person,
                    HorizontalAlignment = HorizontalAlignment.Center
                };
                personLabel.AddThemeFontSizeOverride("font_size", 36);
                _creditsContainer.AddChild(personLabel);
            }
            
            var spacer = new Control();
            spacer.CustomMinimumSize = new Vector2(0, 30);
            _creditsContainer.AddChild(spacer);
            
            colorIndex++;
        }
    }

    private void OnBackPressed()
    {
        GD.Print("Back to Main Menu");
        GetTree().ChangeSceneToFile("res://scenes/UI/MainMenu.tscn");
    }
}
