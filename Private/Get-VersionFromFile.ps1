Function Get-VersionFromFile {
    
    [CmdletBinding()] 
    param(
        [Parameter(Position = 0, Mandatory = $false)] [string] $FileName = "version.props"
    )

    $FilePath = Join-Path $(Get-Location) $FileName
    $XmlFile = [xml](Get-Content $FilePath)
    
    $Version = $XmlFile.Project.PropertyGroup.Version

    if (-Not $Version) {
        throw ("Version not found")
    }

    return $Version
}
