Function Invoke-DotnetBuild {
    
    [CmdletBinding()]
    Param(
        [Parameter(Position = 0, Mandatory = $true)] [string] $Project,
        [Parameter(Position = 1, Mandatory = $false)] [string] $Configuration = "Release"
    )
    
    Write-Host ""

    # Validation
    If (-Not (Test-Path $Project)) {
        throw "$Project not found"
    }

    $Args = @('build', '--configuration', $Configuration, '--no-incremental', '--force')
    $Args += $project
    
    Start-ProcessSafe "dotnet $Args"

}