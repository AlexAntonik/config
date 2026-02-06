{pkgs, ...}: {
  programs = {
    fuse.userAllowOther = true; # Allow users to mount FUSE filesystems
    mtr.enable = true; # My traceroute
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
  };

  environment.systemPackages = with pkgs; [
    wireguard-tools # WireGuard tools
    fastfetch # Modern neofetch    
    bottom # another tui system usage interface
    btop # Better htop
    fzf # Fuzzy search
    gh # GitHub cli
    git-filter-repo # Git history ez rewrite
    yazi # TUI file explorer
    cloc # Count lines of code
    duf # Utility for viewing disk usage in terminal
    dysk # Get information on your mounted disks tool
    dig # DNS tests 
    eza # Beautiful ls replacement
    gawk # GNU awk
    gh # GitHub CLI (enabled in home manager)
    htop # Simple terminal-based system monitor
    tldr # Simplified man
    inxi # System information tool
    killall # Command to kill processes
    lm_sensors # Hardware monitoring
    lshw # Hardware information tool
    ncdu # Disk usage analyzer
    pciutils # PCI utilities
    jq # Command-line JSON processor
    ripgrep # Fast search tool
    socat # Multipurpose relay
    sops # Securely edit files with encryption
    speedtest-cli # Terminal speedtest
    unrar # RAR archive extractor
    unzip # ZIP archive extractor
    usbutils # USB utilities
    wget # Network downloader
  ];
}
