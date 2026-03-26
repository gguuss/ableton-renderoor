# Load required assembly for SendKeys
Add-Type -AssemblyName System.Windows.Forms

Function Start-SleepWithProgress {
    Param([int]$seconds)
    for ($i = 1; $i -le $seconds; $i++) {
        $percent = ($i / $seconds) * 100
        Write-Progress -Activity "Sleeping" -Status "Progress: $percent%" -PercentComplete $percent
        Start-Sleep -Seconds 1
    }
    Write-Progress -Activity "Sleeping" -Completed
}

Function ActivateAbleton {
    $wshell = New-Object -ComObject wscript.shell
    # Find the process and use its MainWindowTitle to activate
    $processName = "Ableton Live 12 Suite" # Example: use the name of the process you want to activate
    $windows = Get-Process | Where-Object {$_.ProcessName -like $processName -and $_.MainWindowTitle -ne ""}
    if ($windows) {
        $windowTitle = $windows[0].MainWindowTitle
        $wshell.AppActivate($windowTitle)
    } else {
        Write-Host "Window for process $processName not found or is minimized."
    }
}

# List of files to open
$files = Get-ChildItem -Path '.' -Filter '*.als' -Recurse -File | Select-Object FullName
$numFiles = $files.Length

Write-Host "Found $numFiles projects"

# TODO: Put all wait times here
$counter = 0
$skipCount = 0 # set to Processing [57 .. upon termination
foreach ($file in $files) {
    $counter = $counter + 1

    if ($counter -ge $skipCount) {

        Write-Host "Processing [$counter of $numFiles]"

        # Open the file with its default application
        $name = $file.FullName
        Write-Host "Opened $name"
        Start-Process $name
        Write-Host "Opened $file"

        # Wait 5 seconds
        Start-SleepWithProgress -Seconds 1

        # Press N
        ActivateAbleton
        [System.Windows.Forms.SendKeys]::SendWait("n")
        Start-SleepWithProgress -Seconds 2
        Write-Host "Pressed N"
        Start-SleepWithProgress -Seconds 2
        ActivateAbleton
        [System.Windows.Forms.SendKeys]::SendWait("n")
        Write-Host "Pressed N"

        # Wait 10 seconds
        Start-SleepWithProgress -Seconds 10

        # Send Ctrl+Shift+R
        ActivateAbleton
        [System.Windows.Forms.SendKeys]::SendWait("^+r")
        Write-Host "Sent Ctrl+Shift+R"

        # Wait 5 seconds
        Start-SleepWithProgress -Seconds 5

        # Press Enter
        ActivateAbleton
        [System.Windows.Forms.SendKeys]::SendWait("~")
        Write-Host "Pressed Enter"

        # Wait 5 seconds
        Start-SleepWithProgress -Seconds 5

        # Press Enter
        ActivateAbleton
        [System.Windows.Forms.SendKeys]::SendWait("~")
        Write-Host "Pressed Enter"

        # Wait 3 minutes
        # TODO wait for output folder to change
        # Start-Sleep -Seconds 180
        Start-SleepWithProgress -Seconds 45
    }
}

Write-Host "Done processing all files."