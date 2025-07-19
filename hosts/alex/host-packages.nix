{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # Productivity & Knowledge Management
    anki # Spaced repetition flashcards
    libreoffice # Office suite
    obsidian # Personal knowledge base
    zathura # PDF viewer

    # Communication & Internet
    discord # Chat and voice communication
    protonvpn-gui # ProtonVPN client
    telegram-desktop # Instant messaging
    tor-browser # Privacy-focused browser
    # chromium
    # vesktop #discord alternative web thingne

    # Media Creation & Editing
    gimp # Image manipulation program
    obs-studio # Screen recording/streaming
    unstable.audacity # Audio editor
    vlc
    mpv # Media player
    ytmdl # YouTube music downloader

    # Development
    android-studio # Android IDE
    nodejs # JavaScript runtime
    supabase-cli
    unstable.code-cursor
    unstable.vscode.fhs # Visual Studio Code with FHS environment
    postgresql

    # Gaming
    prismlauncher # Minecraft launcher
    # lutris # Game launchers gog epic games etc
  ];
}
