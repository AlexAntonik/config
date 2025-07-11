{
  host,
  pkgs,
  username,
  ...
}:
{
  home.packages = [
    (import ./emopicker9000.nix { inherit pkgs; })
    (import ./task-waybar.nix { inherit pkgs; })
    (import ./nvidia-offload.nix { inherit pkgs; })
    (import ./wallsetter.nix {
      inherit pkgs;
      inherit username;
    })
    (import ./toggleTouchpad.nix {
      inherit pkgs;
      inherit host;
    })
    (import ./toggleDisplay.nix {
      inherit pkgs;
      inherit host;
    })
    (import ./rofi-launcher.nix { inherit pkgs; })
    (import ./hm-find.nix { inherit pkgs; })
    (import ./screenshootin.nix { inherit pkgs; })
    (import ./oneshot.nix { inherit pkgs; })
    (import ./toggleXWaylandScale.nix { inherit pkgs; })
  ];
  imports = [
    ./clipboard.nix
  ];
}
