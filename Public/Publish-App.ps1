Function Publish-App {
    
    [CmdletBinding()]
    Param(
        [Parameter(Position = 0, Mandatory = $true)] [string] $Artifact,
        [Parameter(Position = 1, Mandatory = $true)] [string] $DeployTo,
        [Parameter(Position = 2, Mandatory = $true)] [string] $AppExec,
        [Parameter(Position = 3, Mandatory = $false)] [string] $AppExecArgs
    )

    # Validate
    If (-Not (Test-Path $Artifact)) {
        Write-Error "Artifact not found"
        exit 1;
    } 

    $AppExecPath = Join-Path $DeployTo $AppExec
    
    # Stop
    Write-Host "Stop running instance..."
    Stop-App $AppExecPath
    

    # Expand
    Write-Host "Expanding new version..."
    If (Test-Path $DeployTo) {
        Remove-Item $DeployTo -Recurse
    }    
    $ProgressPreference = "SilentlyContinue"
    Expand-Archive -Path $Artifact -DestinationPath $DeployTo -Force
    Remove-Item $Artifact


    # Start
    If ($ENV:OS -Ne "Windows_NT") {
        Write-Host "Set $AppExecPath executable"
        chmod 755 $AppExecPath        
    }

    Write-Host "Start instance..."        
    Start-App $AppExecPath $AppExecArgs
}