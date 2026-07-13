{ pkgs, ... }:
{
  fonts = {
    enableDefaultPackages = true;
    fontDir.enable = true;
    packages = with pkgs; [
      nerd-fonts.jetbrains-mono
      montserrat
      dejavu_fonts
      noto-fonts-color-emoji
      noto-fonts-cjk-sans
      font-awesome
      material-icons
    ];
    fontconfig = {
      defaultFonts = {
        serif = [ "Montserrat" ];
        sansSerif = [ "Montserrat" ];
        monospace = [ "JetBrains Mono" ];
        emoji = [ "Noto Color Emoji" ];
      };
    };
  };
}
