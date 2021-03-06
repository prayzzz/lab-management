@{    
    RootModule           = 'Lab-Management.psm1'
    ModuleVersion        = '1.0.0'
    GUID                 = '14BBD38E-A5DA-4D1E-9831-977F95FDD879'
    Author               = 'Patrick Bachmann (https://github.com/prayzzz)'
    Copyright            = 'Copyright (c) 2018 Patrick Bachmann (https://github.com/prayzzz)'
    Description          = 'Homelab management module'
    
    PowerShellVersion    = '6.0'
    CompatiblePSEditions = 'Core'

    FunctionsToExport    = @(
        'Backup-MsSqlDatabase'
        'Publish-ArtifactFromUrl'
        'Publish-DotNetCore')
    CmdletsToExport      = '*'
    VariablesToExport    = '*'
    AliasesToExport      = '*'

    PrivateData          = @{
        PSData = @{
            LicenseUri = 'https://github.com/prayzzz/lab-management/blob/master/LICENSE'
            ProjectUri = 'https://github.com/prayzzz/lab-management/'
            Tags       = @('')
            IconUri    = ''
        }
    }    
}    