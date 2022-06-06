
$script_filepath = $args[0]

Write-Output "File to be deployed: '$script_filepath'"

# This script, as is, can't deploy an Ingame Script on Linux
# Couldn't play on Linux and figure out the path to the scripts, so couldn't udpate this

<# 

# Check if the file trying to be deployed is a valid ingame script file based on the template
if ($args[1] -notmatch "Script.cs") {
    Write-Error "Trying to deploy a file that isn't an ingame script. Focus on the script window."

    EXIT
}

# Get the Space Engineers local user directory from the enviroment variables
$space_engineers_user_directory = "$env:USERPROFILE/AppData/Roaming/SpaceEngineers"
$space_engineers_scripts_directory = "$env:USERPROFILE/AppData/Roaming/SpaceEngineers/IngameScripts/local"

# Check if the Space Engineers folder exists at the user folder
if (-Not (Test-Path -Path $space_engineers_user_directory)) {
    Write-Error "Cannot find Space Engineers directory at: '$space_engineers_user_directory'"

    EXIT
} else { # If the Space Engineers directory exists, check for the Ingame Scripts subdirectory
    if (-Not (Test-Path -Path $space_engineers_scripts_directory)) {
        Write-Warning "Ingame Scripts subdirectory not found, creating one..."

        # Create the subfolder for the Ingame Scripts in case it doesn't exist yet into the Space Engineers folder
        mkdir $space_engineers_scripts_directory
    }
}

# Generate the script name from the script folder name
$script_folder = "$($args[2])".Replace("scripts/","")

# Find the namespace on the file and get its name
$script_namespace = Select-String -Pattern "namespace(.*){" -Path $script_filepath | Select-Object -ExpandProperty Line
$script_namespace = "$script_namespace".Replace("namespace ","").Replace(" {","")

# Check if there is a namespace on the script
if (-Not ($script_namespace)) {
    Write-Warning "No namespace found on script."
} elseif (-Not ($script_namespace -eq $script_folder)) {  # And double-check that the script folder and the namespace are the same
    Write-Warning "Script namespace ($script_namespace) and script folder ($script_folder) are different."
}

# Defaults name of the script to the folder name
$script_name  = $script_folder

# Find the region identifier on the file using the script name and get the line where it starts
$region_identifier = "#region $script_name"
$script_region_start = Select-String -Pattern $region_identifier -Path $script_filepath | Select-Object -ExpandProperty LineNumber

# Check if the region identifier uses a different name from script
if (-Not $script_region_start) {
    # If region identifier mismatches from script name, get the one that is being used
    $region_identifier = (Select-String -Pattern "#region(.*)" -Path $script_filepath | Select-Object -ExpandProperty Line).Trim()

    # Check if the mismatched region identifier was found
    if (-Not $script_region_start) {

        # Mismatched region identifier found, get its position on script
        $script_region_start = Select-String -Pattern $region_identifier -Path $script_filepath | Select-Object -ExpandProperty LineNumber

        Write-Warning "Region identifier mismatch from script name. Used region identifier: '$region_identifier'"
    } else {
        Write-Error "Region identifier not found on script."

        EXIT
    }
}

# Get the end of the region from the script
$script_region_end = Select-String -Pattern "#endregion" -Path $script_filepath | Select-Object -ExpandProperty LineNumber

# Sanity Check Debug
Write-Output "Region identifier '$region_identifier' for script '$script_name' starts at line $script_region_start and ends at line $script_region_end."

# Set the destination directory where the script will be deployed
$deployment_folder = "$space_engineers_user_directory/IngameScripts/local/$script_name"

# Sanity Check Debug
Write-Output "Target folder for deployment: '$deployment_folder'"

# Check if subdirectory with the script name doesn't exist in the user profile scripts folder
if (-Not (Test-Path -Path $deployment_folder)) {
    
    # Make a folder for the script
    mkdir $deployment_folder

} else {

    # Script folder on user local scripts already exists, check for current revision and back it up
    if (Test-Path -Path "$deployment_folder/Script.cs" -PathType Leaf) {
        
        # Check if a backup exists and deletes it if so
        if (Test-Path -Path "$deployment_folder/Script.cs.backup" -PathType Leaf){
            Remove-Item -Path "$deployment_folder/Script.cs.backup"
        }
        
        # Backup old version as .backup before deploying current version
        Rename-Item -Path "$deployment_folder/Script.cs" -NewName "Script.cs.backup"
    }
}

# Deploy script to its own folder on the local scripts user folder
$deployed_script = "$deployment_folder/Script.cs"
Copy-Item -Path $script_filepath -Destination $deployed_script

# Trims unnecessary lines from deployed script
(Get-Content -Path $deployed_script)[($script_region_start+2)..($script_region_end-2)] | Out-File $deployed_script -Force

# Trims leading empty spaces from script (loses indentation, doesn't matter, Space Engineers count empty spaces)
(Get-Content -Path $deployed_script) | ForEach-Object {$_.Trim()} | Set-Content $deployed_script -Force

#>