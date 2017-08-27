Function Invoke-DotnetTest {
    
    [CmdletBinding()]
    Param(
        [Parameter(Position = 0, Mandatory = $true)] [string] $Project,
        [Parameter(Position = 1, Mandatory = $false)] [string] $Configuration = "Release",
        [Parameter(Position = 2, Mandatory = $false)] [switch] $NoRestore,
        [Parameter(Position = 3, Mandatory = $false)] [switch] $NoBuild
    )
    
    Write-Host ""

    # Validation
    If (-Not (Test-Path $Project)) {
        throw "$Project not found"
    }

    $ProjectName = (Get-Item $Project).BaseName;

    # Build command
    $Args = @('test', '--configuration', $Configuration)
    $Args += "`"--logger:trx;LogFileName=../$ProjectName.trx`""

    If ($NoRestore) {
        $Args += '--no-restore'
    }

    If ($NoBuild) {
        $Args += '--no-build'
    }

    $Args += $project    

    # Execute command
    Start-ProcessSafe "dotnet $Args"

}