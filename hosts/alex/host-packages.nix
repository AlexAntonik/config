{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # Productivity & Knowledge Management
    anki # Spaced repetition flashcards
    libreoffice # Office suite
    obsidian # Personal knowledge base

    # Communication & Internet
    tor-browser # Privacy-focused browser
    chromium
    discord # Chat and voice communication

    # Media Creation & Editing
    gimp # Image manipulation program
    unstable.audacity # Audio editor
    obs-studio # Screen recording/streaming

    # Development
    android-studio # Android IDE
    nodejs # JavaScript runtime
    # Gaming
    # lutris # Game launchers gog epic games etc
    unstable.code-cursor
    prismlauncher # Minecraft launcher

    telegram-desktop # Instant messaging
    # Development Tools
    unstable.vscode.fhs # Visual Studio Code with FHS environment
  ];
}
