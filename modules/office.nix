{ pkgs, ... }:
{
  xdg.mime.defaultApplications = {
    "application/pdf" = "org.pwmt.zathura.desktop";

    # Writer
    "application/msword" = "com.collaboraoffice.Office.desktop";
    "application/rtf" = "com.collaboraoffice.Office.desktop";
    "text/rtf" = "com.collaboraoffice.Office.desktop";
    "application/vnd.ms-word" = "com.collaboraoffice.Office.desktop";
    "application/vnd.oasis.opendocument.text" = "com.collaboraoffice.Office.desktop";
    "application/vnd.openxmlformats-officedocument.wordprocessingml.document" = "com.collaboraoffice.Office.desktop";
    "application/vnd.openxmlformats-officedocument.wordprocessingml.template" = "com.collaboraoffice.Office.desktop";
    "application/vnd.ms-word.document.macroEnabled.12" = "com.collaboraoffice.Office.desktop";

    # Calc
    "application/vnd.ms-excel" = "com.collaboraoffice.Office.desktop";
    "application/vnd.oasis.opendocument.spreadsheet" = "com.collaboraoffice.Office.desktop";
    "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" = "com.collaboraoffice.Office.desktop";
    "application/vnd.openxmlformats-officedocument.spreadsheetml.template" = "com.collaboraoffice.Office.desktop";
    "application/vnd.ms-excel.sheet.macroEnabled.12" = "com.collaboraoffice.Office.desktop";
    "text/csv" = "com.collaboraoffice.Office.desktop";
    "application/csv" = "com.collaboraoffice.Office.desktop";
    "text/tab-separated-values" = "com.collaboraoffice.Office.desktop";

    # Impress
    "application/vnd.ms-powerpoint" = "com.collaboraoffice.Office.desktop";
    "application/vnd.oasis.opendocument.presentation" = "com.collaboraoffice.Office.desktop";
    "application/vnd.openxmlformats-officedocument.presentationml.presentation" = "com.collaboraoffice.Office.desktop";
    "application/vnd.openxmlformats-officedocument.presentationml.template" = "com.collaboraoffice.Office.desktop";
    "application/vnd.ms-powerpoint.presentation.macroEnabled.12" = "com.collaboraoffice.Office.desktop";

    # Draw
    "application/vnd.oasis.opendocument.graphics" = "com.collaboraoffice.Office.desktop";
    "application/vnd.visio" = "com.collaboraoffice.Office.desktop";
  };
  environment.systemPackages = [
    pkgs.collabora-desktop # Office suite
    pkgs.zathura # PDF viewer
  ];
}
