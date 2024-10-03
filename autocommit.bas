Option _Explicit
' Autocommit by Paul Robinson
' Thursday, October 5, 2024

' This program opens a configuration file located in either the current directory
' (The one this program was invoked from) or the specified directory in the command line.
' We read the version number including build number (the last dotted decimal)
' bump it up by 1, then rewrite it back

'$Include:'Version.bi'
'$include:'L:\Programing\$LIBRARY\errors.bi'
Const UCa = "A"
Const UCz = "Z"
Const Underscore = Asc("_")
Const Quote = Chr$(34) ' "
Const FALSE = 0
Const TRUE = Not FALSE

Dim As String TargetFile, TargetDateLine, TargetSourceLine, TargetDayLine
Dim As String VersionString, GitLocation, GitCommand, ErrF
Dim As Long EL, ER

' The following are the valwes this program uses
' If you don't like them, change them and recompile

TargetFile = "Version.bi" '             This is the file we arw going to edit
TargetSourceLine = "Const Version=" '   This is the value we are going to read and change
TargetDateLine = "Const VersionDate=" ' Optional field replaced with today's date       \
TargetDayLine = "Const VersionDay=" '   Optional field replaced with today's day of week

' This only used on Windows
$If WIN Then
    Dim As String TargetFileVersion
    TargetFileVersion = "$VersionInfo:FileVersion=" ' Optional field replaced with Sourelinr value
$End If
GitLocation = "C:\Program Files\Git\cmd\git.exe " ' Location of Git executable
GitCommand = "commit -m " + Quote + "Revision " '   Start of command to give Git


Dim As String FileLine, Target
Dim As Integer InF, OutF, I



If _CommandCount <> 0 Then ' Process command
    If UCase$(Command$(1)) = "-H" Or UCase$(Command$(1)) = "-H" Then Help
    ' Otherwise,,,
    Target = Command$(1) ' Get work directory
End If
Print "Autoccommit Ver. "; Version; " ("; VersionDate; ")"


InF = FreeFile
OutF = FreeFile

'Describe what we're doing if error occurred
ErrF = "Opening version file"

On Error GoTo Error1
Open TargetFile For Input As #InF



' Start the display
Width 15, 9




Print "ÖÄÄÄÄÄÄÄÄÄÄÄÄ·"
Print "º            º"
Print "º Click here º"
Print "º  to commit º"
Print "º            º"
Print "ÓÄÄÄÄÄÄÄÄÄÄÄÄ½"
Print "Ready"
Do
    If _MouseInput Then
        If _MouseButton(1) Then

        End If
    End If

Loop Until InKey$ <> ""
End
' Primary Error handler
Error1:
ER = Err: EL = _ErrorLine
Resume Quit



Quit:
Print "?Error"; ER; "when "; ErrF; " on line"; EL; "described as "
Print _ErrorMessage$(ER)
End



End

Sub Help
    Print "AutoCommit - Version "; Version; " of "; VersionDay; ", "; VersionDate
End Sub
