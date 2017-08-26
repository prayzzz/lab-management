Function Stop-App {
    
    [CmdletBinding()]
    Param(
        [Parameter(Position = 0, Mandatory = $true)] [string] $AppExec
    )
    
    $PidFile = "$($AppExec).pid"

    if (!(Test-Path $PidFile)) {
        Write-Warning "$PidFile not found"
        return 0;
    }
    
    # read process id
    $AppId = Get-Content $PidFile

    # stop process
    Get-Process -Id $AppId -ErrorAction SilentlyContinue | Stop-Process -PassThru | Out-Null
    Write-Host "Stopped process $AppId"
   
    # remove pid file
    Remove-Item $PidFile
}