{ pkgs, ... }:
{
  xdg.mime.defaultApplications = {
    "application/pdf" = "org.pwmt.zathura.desktop";
    "application/msword" = "writer.desktop";
    "application/vnd.openxmlformats-officedocument.wordprocessingml.document" = "writer.desktop";
  };
  environment.systemPackages = [
    pkgs.libreoffice-qt-fresh # Office suite
    pkgs.zathura # PDF viewer
  ];
}
