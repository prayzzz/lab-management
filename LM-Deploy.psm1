function Start-App {

    [CmdletBinding()]
    param(
        [Parameter(Position = 0, Mandatory = $true)] [string] $app,
        [Parameter(Position = 1, Mandatory = $false)] [string] $args
    )

    if (!(Test-Path $app)) {
        Write-Error "App not found"
        exit 1
    }

    # start process
    $process = $null;
    if ($args) {
        $process = Start-Process $app $args -passthru        
    }
    else {
        $process = Start-Process $app -passthru    
    }

    Write-Host "Started $app $args"
    Write-Host "ProcessId  $($process.Id)"

    # write pid file
    $process.Id | Out-File "$($app).pid"
}

function Stop-App {
    
    [CmdletBinding()]
    param(
        [Parameter(Position = 0, Mandatory = $true)] [string] $app
    )
    
    $pidFile = "$($app).pid"

    if (!(Test-Path $pidFile)) {
        Write-Error "$pidFile not found"
        exit 1
    }
    
    # read process id
    $appId = Get-Content $pidFile

    # stop process
    Get-Process -Id $appId -ErrorAction SilentlyContinue | Stop-Process -PassThru | Out-Null
    Write-Host "Stopped process $appId"
   
    # remove pid file
    Remove-Item $pidFile
}

export-modulemember -function Start-App, Stop-App