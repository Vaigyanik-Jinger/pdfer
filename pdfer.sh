#!/bin/bash

# Save the current working directory
cwd=$(pwd)

# Function to run when Ctrl-C is pressed
cleanup() {
  echo "Ctrl-C was pressed. Cleaning up before exiting..."
  rm -r vid_notes.sh simpics.py temp
  exit 1
}

# Set up the signal handler
trap cleanup SIGINT


# Copy files from $HOME/Pdfer to the current directory
cp -r "$HOME/Pdfer"/* .

# Check if $1 is provided before running vid_notes.sh
if [ -n "$1" ]; then
    bash vid_notes.sh "$1"
else
    echo "Usage: $0 argument"
fi

# Clean up by removing copied files and specified scripts
rm -r vid_notes.sh simpics.py

# Return to the original working directory
cd "$cwd"
