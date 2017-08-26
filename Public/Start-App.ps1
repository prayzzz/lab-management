Function Start-App {

    [CmdletBinding()]
    Param(
        [Parameter(Position = 0, Mandatory = $true)] [string] $AppExec,
        [Parameter(Position = 1, Mandatory = $false)] [string] $Args
    )

    if (!(Test-Path $AppExec)) {
        Write-Error "App not found"
        exit 1
    }

    # start process
    $Process = $null;
    if ($Args) {
        $Process = Start-Process $AppExec $Args -passthru        
    }
    else {
        $Process = Start-Process $AppExec -passthru    
    }

    Write-Host "Started $AppExec $Args"
    Write-Host "ProcessId  $($Process.Id)"

    # write pid file
    $Process.Id | Out-File "$($AppExec).pid"
}