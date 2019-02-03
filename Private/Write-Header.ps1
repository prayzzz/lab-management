Function Write-Header {
    
    [CmdletBinding()] 
    param (
        [Parameter(Position = 0, Mandatory = $true)][string] $Message,
        [ConsoleColor] $Color = "Green"
    )
    
    Write-Host ""
    Write-Host "┌────────────────────────────────────────────────────┐" -ForegroundColor $Color
    Write-Host "│ $($Message.PadRight(50)) │                          " -ForegroundColor $Color
    Write-Host "└────────────────────────────────────────────────────┘" -ForegroundColor $Color
    Write-Host ""
    
}