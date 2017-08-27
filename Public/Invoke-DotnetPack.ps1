Function Invoke-DotnetPack {
    
    [CmdletBinding()]
    Param(
        [Parameter(Position = 0, Mandatory = $true)] [string] $Project,
        [Parameter(Position = 1, Mandatory = $false)] [string] $OutputFolder,
        [Parameter(Position = 2, Mandatory = $false)] [string] $VersionSuffix,
        [Parameter(Position = 3, Mandatory = $false)] [string] $Configuration = "Release",
        [Parameter(Position = 4, Mandatory = $false)] [switch] $NoRestore,
        [Parameter(Position = 5, Mandatory = $false)] [switch] $NoBuild
    )
    
    Write-Host ""

    # Validation
    If (-Not (Test-Path $Project)) {
        throw "$Project not found"
    }

    $Args = @('pack', '--configuration', $Configuration)

    If ($OutputFolder) {
        $Args += '--output'
        $Args += $OutputFolder
    }

    If ($VersionSuffix) {
        $Args += '--version-suffix'
        $Args += $VersionSuffix
    }

    If ($NoRestore) {
        $Args += '--no-restore'
    }

    If ($NoBuild) {
        $Args += '--no-build'
    }

    $Args += $project

    Start-ProcessSafe "dotnet $Args"
}