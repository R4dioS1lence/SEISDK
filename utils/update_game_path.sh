#!/bin/bash

# Set the new Game Path from the task argument
new_game_path=$1

# Get the .csproj file to change the Game Path
csproj_file=$(realpath -s ./SpaceEngineers.csproj) 

# Sanity Debug Check
echo ".csproj file path: '$csproj_file'"

# Extract the Sandbox.Common.dll HintPath line from the .csproj where the current Game Path resides
hintPath_full_string=$(grep 'Sandbox.Common.dll</HintPath>' $csproj_file)

# Remove trailing spaces and HintPath identifier
hintPath_full_string=${hintPath_full_string/*<HintPath>/}
hintPath_full_string=${hintPath_full_string/Sandbox.Common.dll\<\/HintPath\>/}

# Sanity Debug Check
echo "Full HintPath for Sandbox.Common.dll: $hintPath_full_string"

# Didn't want to use sed, but it's bundled on fresh install

# Replace current game path with provided path
sed -i "s|$hintPath_full_string|$new_game_path/Bin64/|g" $csproj_file