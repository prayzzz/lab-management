Function Publish-SupervisorApp {
    
    [CmdletBinding()]
    Param(
        [Parameter(Position = 0, Mandatory = $true)] [string] $Artifact,
        [Parameter(Position = 1, Mandatory = $true)] [string] $DeployTo,
        [Parameter(Position = 2, Mandatory = $true)] [string] $AppExec,
        [Parameter(Position = 3, Mandatory = $true)] [string] $AppName
    )

    # Validate
    If ($ENV:OS -Eq "Windows_NT") {
        throw "Windows is not supported"
    }

    which supervisorctl
    Test-ExitCode $LASTEXITCODE "which supervisorctl"

    If (-Not (Test-Path $Artifact)) {
        throw "$Artifact not found"
    } 
    

    # Stop
    Write-Host "Stop running instance..."    
    Start-ProcessSafe "supervisorctl stop $AppName"
        

    # Expand
    Write-Host "Expanding new version..."
    If (Test-Path $DeployTo) {
        Remove-Item $DeployTo -Recurse -Force
    }    
    $ProgressPreference = "SilentlyContinue"
    Expand-Archive -Path $Artifact -DestinationPath $DeployTo -Force
    Remove-Item $Artifact


    # Start
    $AppExecPath = Join-Path $DeployTo $AppExec    
    Write-Host "Set $AppExecPath executable..."
    chmod 755 $AppExecPath        

    Write-Host "Start instance..."        
    Start-ProcessSafe "supervisorctl start $AppName"
}