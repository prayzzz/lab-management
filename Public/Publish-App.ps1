Function Publish-App {
    
    [CmdletBinding()]
    Param(
        [Parameter(Position = 0, Mandatory = $true)] [string] $Artifact,
        [Parameter(Position = 1, Mandatory = $true)] [string] $DeployTo,
        [Parameter(Position = 2, Mandatory = $true)] [string] $AppExec
    )

    $AppExecPath = Join-Path $DeployTo $AppExec

    Write-Host "Stop running instance..."
    Stop-App $AppExecPath

    
    Write-Host "Expanding new version..."
    If (Test-Path $DeployTo) {
        Remove-Item $DeployTo -Recurse
    }    
    $ProgressPreference = "SilentlyContinue"
    Expand-Archive -Path $Artifact -DestinationPath $DeployTo -Force
    Remove-Item $Artifact

    Write-Host "Start instance..."    
    If ($ENV:OS -Ne "Windows_NT") {
        Write-Host "Apply file permission"
        chmod 755 $AppExecPath        
    }
    Start-App $AppExecPath
}