$IncludeOnce
' Leave the next line alone, it is automatically adjusted; don't add comment
Const Version = "1.0.1.46"
' Remove the next line if you don't save date
$Let VERSIONDATE = TRUE
Const VersionDate = "October 06, 2024"
' Remove the next line if you don't save day of week
$Let VERSIONDAY = TRUE
Const VersionDay = "Sunday"
' This block is only used on Windows
$If WIN Then
    ' The next line will be automatically replaced
    $VersionInfo:FileVersion='1.0.1.46'
    $VersionInfo:LegalCopyright='MIT License'
    $VersionInfo:CompanyName='Paul Robinson'
    $VersionInfo:InternalName='AutoCommit.bas'
$End If

