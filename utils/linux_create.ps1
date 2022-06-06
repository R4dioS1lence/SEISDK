
# Scrip Name as entered by user
$name = $args[0]

# C# Script filename
$cs_script = "Script.cs"

# Check if the Template directory exists
$template_directory = "$(Get-Location)/scripts/Template"
IF (-Not (Test-Path -Path "$template_directory")) {
    Write-Error "Script template folder not found in $template_directory"
    
    EXIT
}

# Check if the Template script exists
$source_cs_script = "$template_directory/$cs_script"
IF  (-Not (Test-Path -Path $source_cs_script -PathType Leaf)) {
    Write-Error "Template source script not found: $source_cs_script"
    
    EXIT
}

# Check if script folder to be created already exists
$destination_directory = "scripts/$name"
IF (Test-Path -Path $destination_directory) {
    Write-Error "Script '$name' already exists"
    
    EXIT
}

# If not, create folder for new script
mkdir $destination_directory

# Copy the template to the new script directory
Copy-Item $source_cs_script -Destination $destination_directory

# Set destination path to the new script
$destination_script = "$destination_directory/$cs_script"

# Replace 'Template' with the new script name on the new script file
(Get-Content $destination_script) -replace "Template", $name | Set-Content $destination_script

Write-Output "The '$name' script skeleton has been created."

EXIT
