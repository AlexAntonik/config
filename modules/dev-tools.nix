{ pkgs, ... }:
{
  # nix shell is preferred but yk
  environment.systemPackages = with pkgs; [
    # Programming languages
    go # Go programming language
    python3
    nixd # Nix LSP
    # dart # Dart language
    # kotlin # Kotlin language
    # typescript # Bad language
    # zulu # Open JDK fast

    # Development tools
    # gcc
    # meson # Build system
    # ninja # Build system
    # gradle # Build system
    # nodejs # JavaScript runtime
    opencode
    supabase-cli
    postgresql
  ];
}