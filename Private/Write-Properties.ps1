Function Write-Properties {
    
    [CmdletBinding()] 
    param(
        [Parameter(Position = 0, Mandatory = $true)] [System.Collections.Hashtable] $Properties,
        [Parameter(Position = 1, Mandatory = $true)] [string] $FileName
    )

    $Properties.GetEnumerator() | ForEach-Object { "$($_.Name)=$($_.Value)" } | Out-File -Encoding ascii $FileName
}
