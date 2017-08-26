Function Publish-App {
    
    [CmdletBinding()]
    Param(
        [Parameter(Position = 0, Mandatory = $true)] [string] $Artifact,
        [Parameter(Position = 1, Mandatory = $true)] [string] $AppExec
    )

    Write-Host "Stop running instance..."
    Stop-App -App $AppExec

    
    Write-Host "Expanding new version..."
    $Folder = (Get-Item $Artifact).Basename    
    If (Test-Path $Folder) {
        Remove-Item $Folder -Recurse
    }    
    $ProgressPreference = "SilentlyContinue"
    Expand-Archive -Path $Artifact -DestinationPath $Folder -Force

    Write-Host "Start instance..."    
    $AppExecPath = Join-Path $Folder $AppExec
    
    If ($ENV:OS -Ne "Windows_NT") {
        Write-Host "Apply file permission"
        chmod 755 $AppExecPath        
    }

    Start-App $AppExecPath
}