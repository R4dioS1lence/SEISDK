# Set the new Game Path from the task argument
$new_game_path = $args[0]

# Get the .csproj file to change the Game Path
$csproj_file = "$(Get-Location)/SpaceEngineers.csproj"

# Sanity Debug Check
Write-Output ".csproj file path: $csproj_file"

# Extract the Sandbox.Common.dll HintPath line from the .csproj where the current Game Path resides
$hintPath_full_string = Select-String -Path $csproj_file -Pattern '<HintPath>(.+?)Sandbox\.Common\.dll<\/HintPath>' | Select-Object -ExpandProperty Line

# Remove trailing spaces and HintPath identifier
$hintPath_full_string = "$hintPath_full_string".Trim().Replace('<HintPath>','').Replace('</HintPath>','')

# Sanity Debug Check
Write-Output "Full HintPath for Sandbox.Common.dll: '$hintPath_full_string'"

# Check if current path is either from Linux or not
if ($hintPath_full_string -like '*/*') {

    # Extract only the path to the game from the string, as copied from Explorer
    $old_game_path =  "$hintPath_full_string".Replace('/Bin64/Sandbox.Common.dll','')

    # Sanity Debug Check
    Write-Output "Game Path currently set to: '$old_game_path'"

    # Replace the current game path in the .csproj with the given game path (while keeping Linux path notation from paths)
    $temp = [System.IO.File]::ReadAllText($csproj_file).Replace($old_game_path, $new_game_path)
    [System.IO.File]::WriteAllText($csproj_file, $temp)
    
} else {

    # Extract only the path to the game from the string, as copied from Explorer
    $old_game_path =  "$hintPath_full_string".Replace('\Bin64\Sandbox.Common.dll','')

    # Sanity Debug Check
    Write-Output "Game Path currently set to: $old_game_path"

    # Replace the current game path in the .csproj with the given game path (while correcting the Windows path notation from paths)
    $temp = [System.IO.File]::ReadAllText($csproj_file).Replace("$old_game_path\Bin64\", "$new_game_path/Bin64/")
    [System.IO.File]::WriteAllText($csproj_file, $temp)

}

# Sanity Debug Check
Write-Output "Game Path changed to: '$new_game_path'"

EXIT
