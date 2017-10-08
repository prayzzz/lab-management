Function Invoke-DotnetBuildApp {
    
    [CmdletBinding()]
    Param(
        [Parameter(Position = 0, Mandatory = $true)] [string] $Project,
        [Parameter(Position = 1, Mandatory = $false)] [string] $Runtime = "linux-x64",        
        [Parameter(Position = 2, Mandatory = $false)] [string] $Configuration = "Release",
        [Parameter(Position = 3, Mandatory = $false)] [string] $VersionSuffix
    )

    Write-Host ""
    
    # Validation
    If (-Not (Test-Path $Project)) {
        throw "$Project not found"
    }

    $GitDateOfLastCommit = git log -1 --format=%cd
    $DateOfLastCommit = [System.DateTimeOffset]::ParseExact($GitDateOfLastCommit, "ddd MMM d HH:mm:ss yyyy K", [System.Globalization.CultureInfo]::InvariantCulture)
    $Version = $DateOfLastCommit.ToString("yyyy.MM.dd") + "." + [System.Math]::Round($DateOfLastCommit.TimeOfDay.TotalMinutes)

    If ($VersionSuffix) {
        $Version += "-$VersionSuffix"
    }
    
    # Write properties for Jenkins
    $Properties = @{
        "BUILD_VERSION" = "$Version"; 
    }
    Write-Properties $Properties ".\build.properties"

    # Build command args
    $Args = @('build', '--configuration', $Configuration, '--no-incremental', '--force')

    $Args += "/property:version=$Version"
    $Args += $project

    # Build app
    Start-ProcessSafe "dotnet $Args"

}