{ pkgs }:

pkgs.writeShellScriptBin "oneshot" ''
  # Function to safely create symlinks with cycle detection
  create_symlink() {
    local source=$1
    local target=$2
    
    # Check if source exists and resolve it
    if [ ! -e "$source" ]; then
      echo "Error: Source file $source does not exist"
      return 1
    fi
    
    # Resolve source to its final destination to prevent cycles
    local real_source=$(readlink -f "$source")
    
    # Remove existing symlink if it exists
    if [ -L "$target" ]; then
      rm "$target"
    # Backup existing regular file if it exists
    elif [ -f "$target" ]; then
      mv "$target" "$target.backup"
    fi
    
    # Create the symlink using resolved path
    ln -s "$real_source" "$target"
  }

  # Ensure target directory exists
  mkdir -p "$HOME/.config/Code/User"

  # Create symbolic links for VS Code configuration
  create_symlink "$HOME/config/dotfiles/vscode/keybindings.json" "$HOME/.config/Code/User/keybindings.json"
  create_symlink "$HOME/config/dotfiles/vscode/settings.json" "$HOME/.config/Code/User/settings.json"

''