{
  pkgs,
  inputs,
  username,
  host,
  ...
}:
let
  inherit (import ./variables.nix) gitUsername;
in
{
  imports = [ 
    ./../../system/boot.nix
    ./../../system/fonts.nix
    ./../../system/hardware.nix
    ./../../system/protonvpnfix.nix   # ProtonVPN workaround
    ./../../system/network.nix
    ./../../system/nh.nix             # Nix helper
    ./../../system/packages.nix
    ./../../system/services.nix
    ./../../system/starship.nix
    ./../../system/git.nix
    ./../../system/steam.nix
    ./../../system/stylix.nix         # Stylix config
    ./../../system/nix.nix
    ./../../system/time.nix
    ./../../system/syncthing.nix
    ./../../system/virtualisation.nix

    inputs.stylix.nixosModules.stylix # Stylix module for themes

    inputs.home-manager.nixosModules.home-manager
  ];

  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
    backupFileExtension = "backup";
    extraSpecialArgs = {
      inherit
        inputs
        username
        host
        ;
    };
    users.${username} = {
      imports = [
        # CLI utilities
        ./../../home/bat.nix
        ./../../home/btop.nix
        ./../../home/emoji.nix
        ./../../home/htop.nix
        ./../../home/fastfetch
        ./../../home/eza.nix
        ./../../home/lazygit.nix
        ./../../home/fzf.nix
        ./../../home/yazi
        ./../../home/zoxide.nix
        ./../../home/gh.nix

        # Applications
        ./../../home/firefox.nix
        ./../../home/virtmanager.nix

        # Theming and appearance
        ./../../home/gtk.nix
        ./../../home/qt.nix
        ./../../home/stylix.nix           # Stylix targets

        # Desktop environment and panels
        ./../../home/hyprland
        ./../../home/waybar.nix
        ./../../home/wlogout
        ./../../home/rofi.nix
        ./../../home/swaync.nix
        ./../../home/swayosd.nix
        ./../../home/ghostty.nix

        # Scripts and some configs
        ./../../home/scripts
        ./../../home/xdg.nix
        ./../../home/zsh
        ./../../home/nvf.nix
      ];
      home = {
        username = "${username}";
        homeDirectory = "/home/${username}";

        # This value determines the Home Manager release that your configuration is
        # compatible with. This helps avoid breakage when a new Home Manager release
        # introduces backwards incompatible changes.
        #
        # You should not change this value, even if you update Home Manager. If you do
        # want to update the value, then make sure to first check the Home Manager
        # release notes.
        stateVersion = "24.11"; #READ COMMENT
      };
    };
  };

  users.mutableUsers = true;
  users.users.${username} = {
    isNormalUser = true;
    description = "${gitUsername}";
    extraGroups = [
      "adbusers"
      "docker"
      "libvirtd"
      "kvm"
      "lp"
      "networkmanager"
      "scanner"
      "wheel"
    ];
    shell = pkgs.zsh;
    ignoreShellProgramCheck = true;
  };
  nix.settings.allowed-users = [ "${username}" ];
}