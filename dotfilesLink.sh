#!/bin/sh

DOTFILES_DIR="$HOME/.dotfiles"
BACKUP_DIR="$HOME/.dotfiles_backup"

# Create backup directory if it doesn't exist
if [ ! -d "$BACKUP_DIR" ]; then
  mkdir -p "$BACKUP_DIR"
fi

# Function to create symlink with backup
link_file() {
  local src="$1"
  local dest="$2"
  
  if [ -e "$dest" ] && [ ! -L "$dest" ]; then
    echo "Backing up existing $dest to $BACKUP_DIR"
    mv "$dest" "$BACKUP_DIR/"
  fi
  
  ln -sf "$src" "$dest"
  if [ $? -eq 0 ]; then
    echo "✓ Linked $dest"
  else
    echo "✗ Failed to link $dest"
  fi
}

# Link dotfiles
link_file "$DOTFILES_DIR/.zshrc" "$HOME/.zshrc"
link_file "$DOTFILES_DIR/.zprofile" "$HOME/.zprofile"
link_file "$DOTFILES_DIR/.zshenv" "$HOME/.zshenv"

# Link sheldon config
mkdir -p "$HOME/.config/sheldon"
link_file "$DOTFILES_DIR/.config/sheldon/plugins.toml" "$HOME/.config/sheldon/plugins.toml"

echo "Done!"
