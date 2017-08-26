Function Invoke-DotnetBuild {
    
    [CmdletBinding()]
    Param(
        [Parameter(Position = 0, Mandatory = $true)] [string] $Project,
        [Parameter(Position = 1, Mandatory = $false)] [string] $Configuration = "Release"
    )
    
    Write-Host ""

    $Args = @('build', '-c', $Configuration)

    $Args = $Args += $project
    
    Write-Host "Running dotnet $Args"
    Write-Host ""

    dotnet $Args
}