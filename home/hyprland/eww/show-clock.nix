{pkgs, ...}: {
  home.packages = [
    (pkgs.writeShellScriptBin "show-clock" ''
      eww open temp-clock
      sleep 2
      eww close temp-clock
    '')
  ];
}