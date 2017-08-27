Function Get-VersionFromFile {
    
    [CmdletBinding()] 
    param(
        [Parameter(Position = 0, Mandatory = $false)] [string] $FileName = "version.props"
    )

    $FilePath = Join-Path $(Get-Location) $FileName

    If (-Not (Test-Path $FilePath)) {
        Write-Warning "$FilePath not found"
        return
    }
    
    $XmlFile = [xml](Get-Content $FilePath)    
    $Version = $XmlFile.Project.PropertyGroup.Version

    if (-Not $Version) {
        Write-Warning "Version not found"
        return
    }

    return $Version
}
