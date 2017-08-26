Function Test-ExitCode {
    
    [CmdletBinding()] 
    param(
        [Parameter(Position = 0, Mandatory = $true)] [string] $code,
        [Parameter(Position = 1, Mandatory = $true)] [string] $command
    )

    if (!($code -eq 0)) {
        Write-Host "Error executing $command" -foregroundcolor Red
        Exit $code
    }
    
}