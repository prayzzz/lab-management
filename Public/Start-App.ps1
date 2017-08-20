Function Start-App {

    [CmdletBinding()]
    Param(
        [Parameter(Position = 0, Mandatory = $true)] [string] $App,
        [Parameter(Position = 1, Mandatory = $false)] [string] $Args
    )

    if (!(Test-Path $App)) {
        Write-Error "App not found"
        exit 1
    }

    # start process
    $Process = $null;
    if ($Args) {
        $Process = Start-Process $App $Args -passthru        
    }
    else {
        $Process = Start-Process $App -passthru    
    }

    Write-Host "Started $App $Args"
    Write-Host "ProcessId  $($Process.Id)"

    # write pid file
    $Process.Id | Out-File "$($App).pid"
}