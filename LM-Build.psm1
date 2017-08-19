function Publish-Dotnet {
    
    [CmdletBinding()]
    param(
        [Parameter(Position = 0, Mandatory = $true)] [string] $project,
        [Parameter(Position = 1, Mandatory = $false)] [string] $outputFolder,
        [Parameter(Position = 2, Mandatory = $false)] [string] $runtime = "linux-x64",        
        [Parameter(Position = 3, Mandatory = $false)] [string] $configuration = "Release"
    )
    
    Write-Host ""

    $args = @('publish', '-r', $runtime, '-c', $configuration)

    if ($outputFolder) {
        $args = $args += '-o'
        $args = $args += $outputFolder
    }

    $args = $args += $project
    
    Write-Host "Running dotnet $args"
    Write-Host ""

    dotnet $args
}

export-modulemember -function Publish-Dotnet