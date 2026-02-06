{ env, ... }:
{
  programs.git = {
    enable = true;
    config = {
      user = {
        name = env.gitUsername;
        email = env.gitEmail;
      };
    };
  };
}
