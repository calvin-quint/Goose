# Check if mapped drive I: exists
if (-not (Get-PSDrive -Name "H" -ErrorAction SilentlyContinue)) {
    # Map drive H: to \\filesrv01\Install
    New-PSDrive -Name "H" -PSProvider FileSystem -Root "\\filesrv01\Install" -Persist
}

# Define the source directory
$sourceDirectory = "H:\Goose"

# Function to check if OneDrive is available
function Check-OneDrive {
    if ($env:OneDrive -ne $null -and $env:OneDrive -ne "") {
        return $true
    } else {
        return $false
    }
}

# Check if OneDrive is available
if (Check-OneDrive) {
    # Set $gooseDirectory to OneDrive path
    $gooseDirectory = "$env:OneDrive\Documents\Goose"
} else {
    # Set $gooseDirectory to UserProfile path
    $gooseDirectory = "$env:USERPROFILE\Documents\Goose"
}

# Check if the directory exists
if (-not (Test-Path $gooseDirectory)) {
    # Copy the entire directory from source to destination
    Copy-Item -Path $sourceDirectory -Destination $gooseDirectory -Recurse -Force
}

# Define the variable for GooseDesktop.exe
$gooseexe = "$gooseDirectory\GooseDesktop.exe"

# Continuous loop
while ($true) {
    # Check if any processes with name containing "goose" are found
    $gooseProcesses = Get-Process | Where-Object { $_.ProcessName -like '*goose*' }

    if ($gooseProcesses) {
        Write-Output "GooseDesktop.exe process found."
    }
    else {
        Write-Output "GooseDesktop.exe process not found. Starting GooseDesktop.exe..."
        # Start GooseDesktop.exe
        Start-Process -FilePath $gooseexe
    }

    # Wait for 5 seconds before next iteration
    Start-Sleep -Seconds 5
}
