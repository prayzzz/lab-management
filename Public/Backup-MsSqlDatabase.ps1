Function Backup-MsSqlDatabase {
    
    [CmdletBinding()]
    Param(
        [Parameter(Position = 0, Mandatory = $true)] [string] $Hostname,
        [Parameter(Position = 1, Mandatory = $true)] [string] $DatabaseName,
        [Parameter(Position = 2, Mandatory = $true)] [string] $Username,
        [Parameter(Position = 3, Mandatory = $true)] [String] $Password,
        [Parameter(Position = 4, Mandatory = $true)] [String] $BackupFolder
    )

    If ($ENV:OS -Eq "Windows_NT") {
        where supervisorctl
        Test-ExitCode $LASTEXITCODE "where supervisorctl"
    }
    Else {
        which supervisorctl
        Test-ExitCode $LASTEXITCODE "which supervisorctl"       
    }

    $Date = [System.DateTime]::Now.ToString("yyyy.MM.dd") + "." + [System.Math]::Round([System.DateTime]::Now.TimeOfDay.TotalMinutes)
    
    $BackupFileName = "${DatabaseName}_${Date}.bak"
    $BackupPath = Join-Path $BackupFolder "${DatabaseName}/${BackupFileName}"
    $BackupScript = "`"BACKUP DATABASE [${DatabaseName}] TO DISK = N'${BackupPath}'`""
    
    $Args = @('-H', $Hostname, '-U', $Username, '-P', $Password, '-Q', $BackupScript)
    
    Start-ProcessSafe "sqlcmd $Args"

}