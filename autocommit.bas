Option _Explicit
' Autocommit by Paul Robinson
' Thursday, October 5, 2024

' This program opens a configuration file located in either the current directory
' (The one this program was invoked from) or the specified directory in the command line

'$Include:'Version.bi'
Const UCa = "A"
Const UCz = "Z"
Const Underscore = Asc("_")
Const Quote = Chr$(34) ' "
Const FALSE = 0
Const TRUE = Not FALSE

Dim As String TargetFile, TargetDateLine, TargetSourceLine

' The following are the valwes this program uses
' If you don't like them, change them and recompile

TargetFile = "Version.bi"
TargetSourceLine = "Const Version="
TargetDateLine = "Const VersionDate="
' This only used on Windows
$If WIN Then
    Dim As String TargetFileVersion
    TargetFileVersion = "$VersionInfo:FileVersion="
$End If





$VersionInfo:LegalCopyright=


Dim As String InFile, OutFile, ErrF, FileLine, Target
Dim As Integer InF, OutF, TypeCount, I
Dim As Long Sz, Current

Print "Autoccommit Ver. "; Version; " ("; VersionDate; ")"
If _CommandCount <> 0 Then ' Process command
    Target = Command$(1)
Else Target = "./"
End If



InF = FreeFile

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




