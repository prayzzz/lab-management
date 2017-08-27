Function Invoke-DotnetPublish {
    
    [CmdletBinding()]
    Param(
        [Parameter(Position = 0, Mandatory = $true)] [string] $Project,
        [Parameter(Position = 1, Mandatory = $false)] [string] $OutputFolder,
        [Parameter(Position = 2, Mandatory = $false)] [string] $VersionSuffix,
        [Parameter(Position = 3, Mandatory = $false)] [string] $Runtime = "linux-x64",        
        [Parameter(Position = 4, Mandatory = $false)] [string] $Configuration = "Release",
        [Parameter(Position = 5, Mandatory = $false)] [switch] $SkipZip
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

    Start-ProcessSafe "dotnet $Args"

    If (-Not $SkipZip) {
        $Version = Get-VersionFromFile
        $ZipName = "$Version.zip"
        Write-Host "Creating $ZipName"

        $ProgressPreference = "SilentlyContinue"
        Compress-Archive -Path publish/* -DestinationPath $ZipName -Force  | Out-Null
    }
}