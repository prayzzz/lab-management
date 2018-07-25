if ($Env:OS -eq "Windows_NT") {
    # TODO
}
else {
    mkdir -p /usr/local/share/powershell/Modules/
    ln -s (Get-Location) /usr/local/share/powershell/Modules/Lab-Management
}