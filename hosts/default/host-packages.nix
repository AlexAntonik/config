{ pkgs, pkgs-unstable, ... }:
{
  environment.systemPackages =
    (with pkgs; [
      # Productivity & Knowledge Management
      anki            # Spaced repetition flashcards
      libreoffice    # Office suite
      obsidian       # Personal knowledge base

      # Communication & Internet
      telegram-desktop # Instant messaging
      discord        # Chat and voice communication

      # Media Creation & Editing
      gimp           # Image manipulation program
      audacity       # Audio editor
      obs-studio     # Screen recording/streaming

      # Development
      android-studio # Android IDE
      nodejs        # JavaScript runtime
    ])
    ++ (with pkgs-unstable; [
      # Development Tools
      vscode.fhs     # Visual Studio Code with FHS environment
    ]);
}
