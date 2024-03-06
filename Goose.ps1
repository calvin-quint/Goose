# Set variables for network drive and its corresponding UNC path
$NetworkDriveLetter = "H"
$NetworkDriveUNC = "\\filesrv01\Install"
$SourceDirectory = "${NetworkDriveLetter}:\Goose"

try {
    # Map network drive if not already mapped
    if (-not (Get-PSDrive -Name $NetworkDriveLetter -ErrorAction SilentlyContinue)) {
        New-PSDrive -Name $NetworkDriveLetter -PSProvider FileSystem -Root $NetworkDriveUNC -Persist -ErrorAction Stop > $null
    }

    # Check if OneDrive is available
    $OneDriveAvailable = $env:OneDrive -ne $null -and $env:OneDrive -ne ""

    # Determine Goose directory based on OneDrive availability
    if ($OneDriveAvailable) {
        $GooseDirectory = "$env:OneDrive\Documents\Goose"
    } else {
        $GooseDirectory = "$env:USERPROFILE\Documents\Goose"
    }

    # Copy Goose directory if it doesn't exist
    if (-not (Test-Path $GooseDirectory)) {
        Copy-Item -Path $SourceDirectory -Destination $GooseDirectory -Recurse -Force -ErrorAction Stop
    }

    # Define the variable for GooseDesktop.exe
    $GooseExe = "$GooseDirectory\GooseDesktop.exe"

    # Continuous loop
    while ($true) {
        # Check if any processes with name containing "goose" are found
        $GooseProcesses = Get-Process | Where-Object { $_.ProcessName -like '*goose*' }

        if ($GooseProcesses) {
            Write-Output "GooseDesktop.exe process found."
        }
        else {
            Write-Output "GooseDesktop.exe process not found. Starting GooseDesktop.exe..."
            # Start GooseDesktop.exe
            Start-Process -FilePath $GooseExe
        }

        # Wait for 5 seconds before next iteration
        Start-Sleep -Seconds 5
    }
}
catch {
    Write-Error "An error occurred: $_"
}
