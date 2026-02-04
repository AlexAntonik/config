{
  flake.nixosModules.starship =
    {
      ...
    }:
    {
      programs = {
        # System wide(Root user) strarship configuration
        starship = {
          enable = true;
          presets = [ "plain-text-symbols" ];
          settings = {
            directory = {
              format = "in [$path]($style)[$read_only]($read_only_style) ";
              truncation_symbol = ".../";
              truncation_length = 4;
            };

            git_metrics = {
              disabled = false;
            };

            time = {
              format = "[$time]($style) ";
              time_format = "%H:%M";
              disabled = false;
            };

            username = {
              style_user = "white bold";
              format = "[$user]($style)";
              aliases = {
                root = "root ";
              };
            };

            hostname = {
              format = "[$ssh_symbol$hostname]($style) ";
              ssh_symbol = "@";
            };
          };
        };
      };
    };
}
