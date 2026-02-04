# { pkgs, ... }:
# {
#   programs.tmux = {
#     enable = true;
#     baseIndex = 1;
#     clock24 = true;
#     escapeTime = 0;
#     extraConfigBeforePlugins = ''
#       set  -g focus-events on
#       set  -g mouse             on

#       # set  -g default-terminal "tmux-256color"
#       # set -ag terminal-overrides ",xterm-256color:RGB,*256col*:RGB,alacritty:RGB,kitty:RGB"

#       bind -n M-1 select-window -t 1
#       bind -n M-2 select-window -t 2
#       bind -n M-3 select-window -t 3
#       bind -n M-4 select-window -t 4
#       bind -n M-5 select-window -t 5
#       bind -n M-6 select-window -t 6
#       bind -n M-7 select-window -t 7
#       bind -n M-8 select-window -t 8
#       bind -n M-9 select-window -t 9

#       bind -n M-Enter new-window
#       bind -n M-s choose-tree -s
#       bind -n M-S new-session
#       bind -n M-q kill-window
#       bind -n M-d detach
#       bind -n M-Q confirm-before -p "Kill entire session? (y/n)" kill-session

#       bind -T copy-mode-vi v send -X begin-selection
#       bind -T copy-mode-vi y send -X copy-pipe-and-cancel "wl-copy || xclip -in -selection clipboard"
#       bind -n M-/ copy-mode \; command-prompt -p "(search down)" "send -X search-forward '%%%'"
#       bind -n M-? copy-mode \; command-prompt -p "(search up)"   "send -X search-backward '%%%'"

#       #status bar
#       set -g status-position bottom
#       set -g status-style bg=default,fg=default
#       set -g status-justify centre
#       set -g status-left ""
#       set -g status-right ""
#       set -g window-status-format "#[fg=white] #I:#W "
#       set -g window-status-current-format "#[fg=#698DDA,bold] #I:#W #[bg=default]"
#     '';

#     plugins = with pkgs.tmuxPlugins; [
#       better-mouse-mode
#     ];
#   };
# }
