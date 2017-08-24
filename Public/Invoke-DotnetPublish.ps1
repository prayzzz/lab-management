Function Invoke-DotnetPublish {
    
    [CmdletBinding()]
    Param(
        [Parameter(Position = 0, Mandatory = $true)] [string] $Project,
        [Parameter(Position = 1, Mandatory = $false)] [string] $OutputFolder,
        [Parameter(Position = 2, Mandatory = $false)] [string] $VersionSuffix,
        [Parameter(Position = 3, Mandatory = $false)] [string] $Runtime = "linux-x64",        
        [Parameter(Position = 4, Mandatory = $false)] [string] $Configuration = "Release"
    )
    
    Write-Host ""

    $Args = @('publish', '-r', $Runtime, '-c', $Configuration)

    If ($OutputFolder) {
        $Args = $Args += '-o'
        $Args = $Args += $OutputFolder
    }

    If ($VersionSuffix) {
        $Args = $Args += '--version-suffix'
        $Args = $Args += $VersionSuffix
    }

    $Args = $Args += $project
    
    Write-Host "Running dotnet $Args"
    Write-Host ""

    dotnet $Args
}