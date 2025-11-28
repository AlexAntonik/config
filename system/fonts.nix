{ pkgs, ... }:

{
  fonts = {
    packages = with pkgs; [
      noto-fonts-color-emoji
      noto-fonts-cjk-sans
      font-awesome
      #symbola
      material-icons
      cantarell-fonts
    ];
  };
}
