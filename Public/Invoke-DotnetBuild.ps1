Function Invoke-DotnetPack {
    
    [CmdletBinding()]
    Param(
        [Parameter(Position = 0, Mandatory = $true)] [string] $Project,
        [Parameter(Position = 4, Mandatory = $false)] [string] $Configuration = "Release"
    )
    
    Write-Host ""

    $Args = @('build', '-c', $Configuration)

    $Args = $Args += $project
    
    Write-Host "Running dotnet $Args"
    Write-Host ""

    dotnet $Args
}