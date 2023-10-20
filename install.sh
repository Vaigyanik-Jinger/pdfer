#!/bin/bash

# System-level dependencies
system_dependencies=("ffmpeg" "geeqie" "rdfind" "imagemagick" "evince")

echo "Checking and installing system-level dependencies..."
for dep in "${system_dependencies[@]}"; do
    if ! command -v "$dep" &> /dev/null; then
        echo "Installing $dep..."
        if [ "$dep" == "imagemagick" ]; then
            # On some systems, 'imagemagick' may be 'convert'
            sudo apt-get install imagemagick || sudo apt-get install graphicsmagick
        else
            sudo apt-get install -y "$dep"
        fi
    else
        echo "$dep is already installed."
    fi
done

# Python dependencies
python_dependencies=("Pillow" "imagehash")

echo "Checking and installing Python dependencies..."
for dep in "${python_dependencies[@]}"; do
    if ! python -c "import $dep" &> /dev/null; then
        echo "Installing $dep..."
        pip3 install "$dep"
    else
        echo "$dep is already installed."
    fi
done

echo "All dependencies have been checked and installed."

mkdir ~/Pdfer
cd ~/Pdfer
rm *

wget https://raw.githubusercontent.com/Vaigyanik-Jinger/pdfer/blob/main/simpics.py
wget https://raw.githubusercontent.com/Vaigyanik-Jinger/pdfer/blob/main/vid_notes.sh
wget https://raw.githubusercontent.com/Vaigyanik-Jinger/pdfer/blob/main/pdfer.sh


# Detect the user's shell
SHELL_NAME=$(basename "$SHELL")

# Your alias definition
ALIAS_COMMAND="alias pdfer='$SHELL_NAME ~/Pdfer/pdfer.sh'"

# Check the shell and append the alias accordingly
if [ "$SHELL_NAME" = "bash" ]; then
  CONFIG_FILE=~/.bashrc
elif [ "$SHELL_NAME" = "zsh" ]; then
  CONFIG_FILE=~/.zshrc
else
  echo "Unsupported shell: $SHELL_NAME. Please add the alias manually to your shell configuration."
  echo "alias pdfer='<shell> ~/Pdfer/pdfer.sh'"
  exit 1
fi

# Append the alias to the detected configuration file
echo "$ALIAS_COMMAND" >> "$CONFIG_FILE"

# Source the configuration file to make the alias available immediately in the current session
source "$CONFIG_FILE"

# Display a message
echo "Alias 'pdfer' added to $CONFIG_FILE and sourced. Please use the command in the following way."
echo "pdfer <file name without extension>"
echo "the files is presently supposed to be .mp4"

rm -- "$0"
cd
