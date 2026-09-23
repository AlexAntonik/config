{ pkgs, ... }:
{
  programs = {
    fuse.userAllowOther = true; # Allow users to mount FUSE filesystems
    mtr.enable = true; # My traceroute
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
  };
  environment.shellAliases = {
    c = "clear";
    ls = "eza --icons --group-directories-first -1";
    ll = "eza --icons -lh --group-directories-first -1 --no-user --long";
    la = "eza --icons -lah --group-directories-first -1";
    tree = "eza --icons --tree --group-directories-first";
  };

  environment.systemPackages = with pkgs; [
    # System info & monitoring
    bottom # like btop but different
    btop
    fastfetch
    htop
    inxi # System information tool
    isd # Systemd services tui

    # Disks & filesystems
    duf # Utility for viewing disk usage in terminal
    dysk # Get information on your mounted disks tool
    ncdu

    # Hardware info
    lm_sensors
    lshw
    pciutils
    usbutils

    # Files & navigation
    yazi
    eza
    ripgrep
    file # Detect file type by content

    # Processes & debugging
    killall
    lsof
    strace # Trace syscalls of a process

    # Network & diagnostics
    curl # HTTP client
    dig
    ethtool # NIC inspection & tuning
    iotop-c # Per-process disk I/O
    ipinfo
    nethogs # Per-process network usage
    nmap 
    socat
    speedtest-cli # Terminal speedtest
    tcpdump 
    traceroute
    wget
    whois
    wireguard-tools

    # Text & data processing
    gawk
    jq
    yq-go # Like jq but for YAML/XML/TOML
    cloc

    # Archives & transfer
    zip
    unzip
    unrar # RAR archive extractor
    rsync # File sync & transfer
    pv # Progress bar in pipes

    # Secrets
    sops
    age

    # Docs
    tldr # Simplified man
  ];
}