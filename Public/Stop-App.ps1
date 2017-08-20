Function Stop-App {
    
    [CmdletBinding()]
    Param(
        [Parameter(Position = 0, Mandatory = $true)] [string] $App
    )
    
    $PidFile = "$($App).pid"

    if (!(Test-Path $PidFile)) {
        Write-Error "$PidFile not found"
        exit 1
    }
    
    # read process id
    $AppId = Get-Content $PidFile

    # stop process
    Get-Process -Id $AppId -ErrorAction SilentlyContinue | Stop-Process -PassThru | Out-Null
    Write-Host "Stopped process $AppId"
   
    # remove pid file
    Remove-Item $PidFile
}