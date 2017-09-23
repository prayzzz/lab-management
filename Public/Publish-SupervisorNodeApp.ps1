Function Publish-SupervisorNodeApp {
    
    [CmdletBinding()]
    Param(
        [Parameter(Position = 0, Mandatory = $true)] [string] $GitRepository,
        [Parameter(Position = 1, Mandatory = $true)] [string] $DeployTo,
        [Parameter(Position = 2, Mandatory = $true)] [string] $AppName
    )

    # Validate
    If ($ENV:OS -Eq "Windows_NT") {
        throw "Windows is not supported"
    }

    which supervisorctl
    Test-ExitCode $LASTEXITCODE "which supervisorctl"

    
    # Stop
    Write-Host "Stop running instance..."    
    Start-ProcessSafe "supervisorctl stop $AppName"
        

    # Expand
    Write-Host "Pulling new version..."
    If (Test-Path $DeployTo) {
        Remove-Item $DeployTo -Recurse -Force
    }    

    Start-ProcessSafe "git clone $GitRepository $DeployTo"
    Set-Location $DeployTo
    Start-ProcessSafe "yarn"


    # Start
    Write-Host "Start instance..."        
    Start-ProcessSafe "supervisorctl start $AppName"
}