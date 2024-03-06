# Get all processes with name containing "goose"
$GooseProcesses = Get-Process | Where-Object { $_.ProcessName -like '*goose*' }

# Kill each process
foreach ($process in $GooseProcesses) {
    Stop-Process -Id $process.Id -Force
}
