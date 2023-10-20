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

