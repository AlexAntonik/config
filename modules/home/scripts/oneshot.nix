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

  # Function to update drawer.css background color
  update_drawer_css() {
    local css_file="$HOME/.config/nwg-drawer/drawer.css"
    local new_color="rgba(88, 88, 88, 0.95)"
    
    if [ -f "$css_file" ]; then
      # Create backup
      cp "$css_file" "$css_file.backup"
      # Replace background-color in window selector
      sed -i "s/background-color: rgba([0-9]\+,[ ]*[0-9]\+,[ ]*[0-9]\+,[ ]*[0-9.]\+)/background-color: $new_color/" "$css_file"
      echo "Updated drawer.css background color"
    else
      echo "Warning: $css_file not found"
    fi
  }

  # Ensure target directory exists
  mkdir -p "$HOME/.config/Code/User"

  # Create symbolic links for VS Code configuration
  create_symlink "$HOME/config/dotfiles/vscode/keybindings.json" "$HOME/.config/Code/User/keybindings.json"
  create_symlink "$HOME/config/dotfiles/vscode/settings.json" "$HOME/.config/Code/User/settings.json"

  # Update drawer.css
  update_drawer_css
''