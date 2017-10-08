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
    
    # Validation
    If (-Not (Test-Path $Project)) {
        throw "$Project not found"
    }

    $GitDateOfLastCommit = git log -1 --format=%cd
    $DateOfLastCommit = [System.DateTimeOffset]::ParseExact($GitDateOfLastCommit, "ddd MMM d HH:mm:ss yyyy K", [System.Globalization.CultureInfo]::InvariantCulture)
    $Version = $DateOfLastCommit.ToString("yyyy.MM.dd") + "." + [System.Math]::Round($DateOfLastCommit.TimeOfDay.TotalMinutes)
    
    # Write properties for Jenkins
    $Properties = @{
        "BUILD_VERSION" = "$Version";
    }
    Write-Properties $Properties ".\build.properties"

    # Build command args
    $Args = @('publish', '--runtime', $Runtime, '--configuration', $Configuration)

    If ($OutputFolder) {
        $Args += '-o'
        $Args += $OutputFolder
    }

    $Args += "/property:version=$Version"
    $Args += $project

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