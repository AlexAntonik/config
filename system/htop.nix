{ ... }:
{
  programs.htop.enable = true;
  programs.htop.settings = {
    color_scheme = 6;
    cpu_count_from_one = false;
    delay = 15;
    fields = [
      "PID"
      "USER"
      "PRIORITY"
      "NICE"
      "M_SIZE"
      "M_RESIDENT"
      "M_SHARE"
      "STATE"
      "PERCENT_CPU"
      "PERCENT_MEM"
      "TIME"
      "COMM"
    ];
    highlight_base_name = true;
    highlight_megabytes = true;
    highlight_threads = true;
    meters = [
      # Левые метры
      "Bar AllCPUs2"
      "Bar Memory"
      "Bar Swap"
      "Text Zram"

      # Правые метры
      "Text Tasks"
      "Text LoadAverage"
      "Text Uptime"
      "Text Systemd"
    ];
  };
}