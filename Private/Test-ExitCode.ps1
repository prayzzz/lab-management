Function Test-ExitCode {
    
    [CmdletBinding()] 
    param(
        [Parameter(Position = 0, Mandatory = $true)] [string] $Code,
        [Parameter(Position = 1, Mandatory = $true)] [string] $Command
    )

    if (!($Code -eq 0)) {
        Write-Host "Error executing $Command" -foregroundcolor Red
        Exit $Code
    }
    
}