{ pkgs, ... }:
{
  programs = {
    # adb.enable = true; # Android Debug Bridge
    # amnezia-vpn.enable = true;
  };
  environment.systemPackages = with pkgs; [
    # Programming languages
    # go # Go programming language
    # nixd # Nix LSP
    # dart # Dart language
    # kotlin # Kotlin language
    # typescript # EXTREMLY BAD language
    # zulu # Open JDK fast

    # Development tools
    # meson # Build system
    # gradle # Build system
    # ninja # Build system
    # nixfmt-rfc-style # Nix code formatter
    # pkg-config # Package configuration tool
    
    # Productivity & Knowledge Management
    # anki # Spaced repetition flashcards
    # libreoffice # Office suite
    # obsidian # Personal knowledge base

    # Communication & Internet
    # telegram-desktop # Instant messaging
    # discord # Chat and voice communication
    # chromium # Web browser

    # Media Creation & Editing
    # gimp # Image manipulation program
    # unstable.audacity # Audio editor
    # obs-studio # Screen recording/streaming

    # Development
    # android-studio # Android IDE
    # nodejs # JavaScript runtime
    # unstable.vscode.fhs # Visual Studio Code with FHS environment
  ];
}
