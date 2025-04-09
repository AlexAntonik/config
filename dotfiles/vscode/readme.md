
# How to sync with current repo

1. Start vscode for default folders creation(maybe unnecessary but for good sake)
2. Create soft links for this files

``` bash
ln -s /home/alex/config/dotfiles/vscode/keybindings.json /home/alex/.config/Code/User/keybindings.json

ln -s /home/alex/config/dotfiles/vscode/settings.json /home/alex/.config/Code/User/settings.json
```

Gonly with absolute path or error 40  

probably not needed now bcs incorporated in oneshot script
