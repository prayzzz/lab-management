Function Invoke-DotnetBuildApp {
    
    [CmdletBinding()]
    Param(
        [Parameter(Position = 0, Mandatory = $true)] [string] $Project,
        [Parameter(Position = 1, Mandatory = $false)] [string] $Runtime = "linux-x64",        
        [Parameter(Position = 2, Mandatory = $false)] [string] $Configuration = "Release"
    )

    Write-Host ""

    $Version = [System.DateTime]::Now.ToString("yyyy.MM.dd") + "." + [System.Math]::Round([System.DateTime]::Now.TimeOfDay.TotalMinutes)
    
    # Write properties for Jenkins
    $Properties = @{
        "BUILD_VERSION" = "$Version"; 
    }
    Write-Properties $Properties ".\build.properties"

    # Build command args
    $Args = @('build', '-r', $Runtime, '-c', $Configuration)

    $Args = $Args += "/property:version=$Version"
    $Args = $Args += $project

    # Build app
    Start-ProcessSafe "dotnet $Args"

}