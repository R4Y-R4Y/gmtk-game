using Godot;
using System.Collections.Generic;
using System.Threading.Tasks;

public partial class Story : Control
{
    private Label _storyLabel;
    private Button _backButton;
    private Button _skipButton;
    
private readonly List<string> _storyText = new()
{
    "In a secret underground lab, time itself has been conquered...",
    "Dr. Miro, a brilliant but reckless scientist, unveils his prototype time machine to a skeptical science council...",
    "During the first live demonstration, he sets the machine to a date in the past...",
    "But a catastrophic malfunction traps him in a repeating time loop...",
    "Each reset spawns temporal anomalies — and unstable clones of himself...",
    "Reality begins to fracture as timelines overlap and paradoxes multiply...",
    "Now, Dr. Miro must work with — alongside — his own copies to fix the timeline...",
    "Solve complex puzzles, uncover the truth behind the loop, and escape before time collapses completely...",
    "Will you break free... or become just another echo in the loop?"
};
    
    private int _currentSentenceIndex = 0;
    private bool _isTyping = false;
    private bool _skipRequested = false;
    
    private float _typingSpeed = 0.05f;
    private float _sentencePause = 2.0f;
    
    public override void _Ready()
    {
        _storyLabel = GetNode<Label>("StoryLabel");
        _backButton = GetNode<Button>("BackButton");
        _skipButton = GetNode<Button>("SkipButton");
        
        _backButton.Pressed += OnBackPressed;
        _skipButton.Pressed += OnSkipPressed;
        
        StartStorySequence();
    }
    
    private async void StartStorySequence()
    {
        _storyLabel.Text = "";
        
        foreach (var sentence in _storyText)
        {
            if (_skipRequested) break;
            
            await TypeSentence(sentence);
            
            if (_skipRequested) break;
            
            await Task.Delay((int)(_sentencePause * 1000));
        }
        
        if (!_skipRequested)
        {
            await Task.Delay(2000);
            StartGame();
        }
    }
    
    private async Task TypeSentence(string sentence)
    {
        _isTyping = true;
        _storyLabel.Text = "";
        
        foreach (char character in sentence)
        {
            if (_skipRequested) 
            {
                _storyLabel.Text = sentence;
                break;
            }
            
            _storyLabel.Text += character;
            await Task.Delay((int)(_typingSpeed * 1000));
        }
        
        _isTyping = false;
    }
    
    private void OnSkipPressed()
    {
        _skipRequested = true;
        StartGame();
    }
    
    private void OnBackPressed()
    {
        _skipRequested = true;
        GetTree().ChangeSceneToFile("res://scenes/UI/MainMenu.tscn");
    }
    
    private void StartGame()
    {
        GetTree().ChangeSceneToFile("res://scenes/Main.tscn");
    }
    
    public override void _Input(InputEvent @event)
    {
        if (@event.IsActionPressed("ui_accept") || @event.IsActionPressed("ui_select"))
        {
            if (_isTyping)
            {
                _skipRequested = true;
            }
        }
    }
}
