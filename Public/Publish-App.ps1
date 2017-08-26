Function Publish-App {
    
    [CmdletBinding()]
    Param(
        [Parameter(Position = 0, Mandatory = $true)] [string] $Artifact,
        [Parameter(Position = 1, Mandatory = $true)] [string] $AppExec
    )

    Write-Host "Stop running instance..."
    Stop-App -App $AppExec
    Test-ExitCode $LASTEXITCODE "Stop-App"
    

    Write-Host "Expanding new version..."
    $Folder = (Get-Item $Artifact).Basename    
    If (Test-Path $Folder) {
        Remove-Item $Folder -Recurse
    }    
    $ProgressPreference = "SilentlyContinue"
    Expand-Archive -Path $Artifact -DestinationPath $Folder -Force
    Test-ExitCode $LASTEXITCODE "Expand-Archive"


    Write-Host "Start instance..."
    $AppExecPath = Join-Path $Folder $AppExec
    Start-App $AppExecPath
    Test-ExitCode $LASTEXITCODE "Start-App"
}