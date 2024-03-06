# Network Drive Setup for GooseDesktop.exe

This PowerShell script sets up a network drive and ensures that the GooseDesktop.exe application is running continuously. It maps a network drive to a specified letter and UNC path, checks for the availability of OneDrive, copies the Goose directory if it doesn't exist, and starts the GooseDesktop.exe process if it's not already running.

## Prerequisites
- PowerShell 3.0 or later
- Permissions to map network drives and copy files

## Usage
1. Set the variables `$NetworkDriveLetter` and `$NetworkDriveUNC` to specify the network drive letter and its corresponding UNC path.
2. Define the `$SourceDirectory` variable to indicate the source directory where GooseDesktop.exe is located.
3. Execute the script.

## Script Flow
1. Maps the network drive if it's not already mapped.
2. Checks for the availability of OneDrive.
3. Determines the location of the Goose directory based on OneDrive availability.
4. Copies the Goose directory if it doesn't exist.
5. Defines the variable for GooseDesktop.exe.
6. Enters a continuous loop:
    - Checks if any processes with names containing "goose" are running.
    - If no GooseDesktop.exe process is found, starts the GooseDesktop.exe process.
    - Waits for 5 seconds before the next iteration.

## Error Handling
- If any error occurs during execution, it will be caught, and an error message will be displayed.

## Important Note
Ensure that GooseDesktop.exe is located in the specified source directory.

## Disclaimer
This script is provided as-is without any warranties. Use it at your own risk.

