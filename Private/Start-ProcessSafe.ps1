Function Start-ProcessSafe {
    
    [CmdletBinding()] 
    param(
        [Parameter(Position = 0, Mandatory = $true)] [string] $Command
    )

    Try {
        Write-Host "Execute command: $Command"
        Write-Host ""

        Invoke-Expression $Command

        Write-Host "Exit Code: $LASTEXITCODE"

        if ($LASTEXITCODE -Ne 0) {
            throw "Command failed"
        }
    }
    Catch [Exception] {
        throw "Command failed"
    }

}