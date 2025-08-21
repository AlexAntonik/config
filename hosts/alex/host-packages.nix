{ pkgs, ... }:
{
  programs = {
    adb.enable = true; # Android Debug Bridge
    amnezia-vpn.enable = true;
  };
  environment.systemPackages = with pkgs; [
    # Programming languages
    go # Go programming language
    nixd # Nix LSP
    dart # Dart language
    kotlin # Kotlin language
    typescript # EXTREMLY BAD language
    # zulu # Open JDK fast

    # Development tools
    meson # Build system
    gradle # Build system
    ninja # Build system
    nixfmt-rfc-style # Nix code formatter
    pkg-config # Package configuration tool
    android-studio # Android IDE
    nodejs # JavaScript runtime
    unstable.code-cursor
    # unstable.vscode.fhs # Visual Studio Code with FHS environment
    supabase-cli
    postgresql

    # Desktop suite
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

    # Gaming
    # vintagestory
    # prismlauncher # Minecraft launcher
    # lutris # Game launchers gog epic games etc
  ];


# only for vintage story mb remove in future
#          |
#         \|/
#          \/
  # nixpkgs.config.permittedInsecurePackages = [
    # "dotnet-runtime-7.0.20"
  # ];
}
