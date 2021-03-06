Function Publish-ArtifactFromUrl {    

    [CmdletBinding()]
    Param(
        [Parameter(Position = 0, Mandatory = $true)] [string] $Name,
        [Parameter(Position = 2, Mandatory = $true)] [string] $ArtifactUrl
    )


    $AppFolder = "/opt/$Name"    
    $ArtifactFile = "$Name.zip"
    $DownloadedArtifactPath = "/tmp/$($ArtifactFile)"


    # Download
    Write-Host "Downloading artifact from $ArtifactUrl"

    If (Test-Path $DownloadedArtifactPath) {
        Remove-Item $DownloadedArtifactPath -Force
    } 
    
    $DownloadCommand = "wget $ArtifactUrl -O $DownloadedArtifactPath"
    Invoke-Expression $DownloadCommand
    if (!($LASTEXITCODE -eq 0)) {
        Write-Host "Error executing '$DownloadCommand'" -foregroundcolor Red
        Exit $LASTEXITCODE
    }


    # Stop service
    $StopService = "systemctl stop $($Name).service"
    Write-Host "Stopping Service"

    Invoke-Expression $StopService
    if (!($LASTEXITCODE -eq 0)) {
        Write-Host "Error executing '$StopService'" -foregroundcolor Red
        Exit $LASTEXITCODE
    }


    # Remove old
    Write-Host "Removing old Deployment"

    If (Test-Path $AppFolder) {
        Remove-Item $AppFolder -Force -Recurse
    } 


    # Unpack new
    Write-Host "Unzipping new Deployment"
    
    $UnzipCommand = "unzip $DownloadedArtifactPath -d $AppFolder"
    Invoke-Expression $UnzipCommand
    if (!($LASTEXITCODE -eq 0)) {
        Write-Host "Error executing '$UnzipCommand" -foregroundcolor Red
        Exit $LASTEXITCODE
    }


    # Start service
    $StartService = "systemctl start $($Name).service"
    Write-Host "Starting Service"

    Invoke-Expression $StartService
    if (!($LASTEXITCODE -eq 0)) {
        Write-Host "Error executing '$StartService'" -foregroundcolor Red
        Exit $LASTEXITCODE
    }
}