Function Publish-DotNetCore {    

    [CmdletBinding()]
    param(    
        [Parameter(Mandatory = $true, Position = 0)] [string] $Name,
        [string] $Project = ""
    )

    $Name = $Name.ToLower()
    $Current = Convert-Path .
    $PublishFolder = Join-Path $Current publish
    $ArtifactSource = Join-Path  "$Current" "publish" "*"
    $ArtifactOutput = Join-Path $Current "$Name.zip"


    Write-Header "Building Project"

    dotnet publish $Project --output $PublishFolder --configuration Release


    Write-Header "Compressing"

    if (Test-Path $ArtifactOutput) {
        Remove-Item $ArtifactOutput
    }

    # Hide Progressbar
    $ProgressPreference = "SilentlyContinue"

    Write-Host "  Compressing '$ArtifactSource'"
    Compress-Archive -Path $ArtifactSource -DestinationPath $ArtifactOutput


    Write-Header "Transfer To Remote"

    scp $ArtifactOutput app01.server.home:/opt/


    Write-Header "Exeuting Remote Deplyoment"

    ssh app01.server.home "cd /opt && pwsh /opt/deploy.ps1 -Name $Name"


    Write-Header "Cleanup"

    Write-Host "  Removing '$PublishFolder'"
    Remove-Item $PublishFolder -Recurse

    Write-Host "  Removing '$ArtifactOutput'"
    Remove-Item $ArtifactOutput


    Write-Header "Done"

}