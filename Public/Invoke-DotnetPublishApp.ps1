Function Invoke-DotnetPublishApp {
    
    [CmdletBinding()]
    Param(
        [Parameter(Position = 0, Mandatory = $true)] [string] $Project,
        [Parameter(Position = 1, Mandatory = $false)] [string] $OutputFolder,
        [Parameter(Position = 3, Mandatory = $false)] [string] $Runtime = "linux-x64",        
        [Parameter(Position = 4, Mandatory = $false)] [string] $Configuration = "Release",
        [Parameter(Position = 5, Mandatory = $false)] [switch] $SkipZip
    )

    Write-Host ""

    $Version = [System.DateTime]::Now.ToString("yyyy.MM.dd") + "." + [System.Math]::Round([System.DateTime]::Now.TimeOfDay.TotalMinutes)
    
    # Write properties for Jenkins
    $Properties = @{
        "BUILD_VERSION" = "$Version";
    }
    Write-Properties $Properties ".\build.properties"

    # Build command args
    $Args = @('publish', '-r', $Runtime, '-c', $Configuration)

    If ($OutputFolder) {
        $Args = $Args += '-o'
        $Args = $Args += $OutputFolder
    }

    $Args = $Args += "/property:version=$Version"
    $Args = $Args += $project

    # Publish app
    Start-ProcessSafe "dotnet $Args"

    # Create zip archive
    If (-Not $SkipZip) {
        $ZipName = "$Version.zip"
        Write-Host "Creating $ZipName"

        $ProgressPreference = "SilentlyContinue"
        Compress-Archive -Path publish/* -DestinationPath $ZipName -Force  | Out-Null
    }
}