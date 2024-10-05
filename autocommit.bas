Option _Explicit
' Autocommit by Paul Robinson
' Thursday, October 5, 2024

' This program opens a configuration file located in either the current directory
' (The one this program was invoked from) or the specified directory in the command line.
' We read the version number including build number (the last dotted decimal)
' bump it up by 1, then rewrite it back

'$Include:'Version.bi'
'$Include:'L:\Programming\$LIBRARY\ERRORS.bi'
'$Include:'datesetup.bi'
Const UCa = "A"
Const UCz = "Z"
Const Underscore = Asc("_")
Const Quote = Chr$(34) ' "
Const FALSE = 0
Const TRUE = Not FALSE

Dim As String TargetFile, TargetDateLine, TargetSourceLine, TargetDayLine
Dim As String VersionString, GitLocation, GitCommand, ErrF

Dim As Long EL, ER
ReDim As String FileLine(0)

' The following are the valwes this program uses
' If you don't like them, change them and recompile

TargetFile = "Version.bi" '             This is the file we arw going to edit
TargetSourceLine = "Const Version=" '   This is the value we are going to read and change
TargetDateLine = "Const VersionDate=" ' Optional field replaced with today's date       \
TargetDayLine = "Const VersionDay=" '   Optional field replaced with today's day of week


' This only used on Windows
Dim As String TargetFileVersion
TargetFileVersion = "$VersionInfo:FileVersion=" ' Optional field replaced with Sourelinr value

GitLocation = "C:\Program Files\Git\cmd\git.exe " ' Location of Git executable
GitCommand = "commit -m " + Quote + "Revision " '   Start of command to give Git

_PaletteColor 3, _RGB32(255, 167, 0) ' Orange
Color 14 ' Yellow
Dim As String FileLine, Target, UpdateLevel
Dim As Integer InF, OutF, I, LineCount, NewLineCount, TargetSourceLineCount, TargetDateLineCount, UpdateValue

' Setup for creatimg new file
Read NewLineCount
Dim As String NewLines(0)
For I = 1 To NewLineCount
    Read NewLines(I)
Next

On Error GoTo Error1
If _CommandCount <> 0 Then ' Process command
    If UCase$(Command$(1)) = "-H" Or UCase$(Command$(1)) = "-H" Then Help
    ' Otherwise,,,
    Target = Command$(1) ' Get work directory
    ChDir Target
End If
Print "AutoCommit Ver. "; Version; " ("; VersionDate; ")"

InF = FreeFile
OutF = FreeFile

'Describe what we're doing if error occurred
ErrF = "Opening version file"

Open TargetFile For Input As #InF
Print "Opening Version Info"
TargetSourceLineCount = 0
TargetDateLineCount = 0
While Not EOF(InF)
    LineCount = LineCount + 1
    ReDim _Preserve FileLine(LineCount)
    Line Input FileLine(LineCount)
    ' Version No. should be ahead of any other declarations
    If Not TargetSourceLineCount Then 'Have not found it
        I = InStr(FileLine(LineCount), TargetSourceLine)
        If I Then ' Found version
            I = _InStrRev(FileLine(LineCount), ".") ' Find last period
            UpdateLevel = Mid$(FileLine(LineCount), I + 1, Len(FileLine(LineCount))) ' Pull off revision strimg
            UpdateValue = Val(UpdateLevel) ' Extract revision value
            UpdateValue = UpdateValue + 1 ' Imcrement revision no.
            UpdateLevel = Left$(FileLine(LineCount), I) + Str$(UpdateValue) ' Put back new version
            TargetSourceLineCount = LineCount ' Don't need to look again
            _Continue
        End If
    End If
    If Not TargetDateLineCount Then
        If InStr(FileLine(LineCount), TargetDateLine) Then
            FileLine(LineCount) = TargetDateLine + Quote + TodaysDate + Quote ' Replace with today
            TargetDateLineCount = LineCount ' Don't need to look again
        End If
    End If


Wend
Close #InF



' Start the display
Start:
Width 20, 10
Cls




Print "靈컴컴컴컴컴컴컴컴�"
Print "� Current Version �"
Print "� 000.000.000.000 �"
Print "�   Click here    �"
Print "�    to commit    �"
Print "�                 �"
Print "聃컴컴컴컴컴컴컴컴�"
Print "Ready     "
Print " (Alt-F4 to Close) "
Do
    If _MouseInput Then
        If _MouseButton(1) Then
            ' Do something
            Locate 1, 10
            Print "Committing..."

            ' Print Version No.
            Locate 3, 3


            'restore after commit
            Locate 1, 10
            Print "Ready        "

        End If
    End If
    'Exit Via ALT-F4
Loop ' Until InKey$ <> ""
End
' Primary Error handler
Error1:
ER = Err: EL = _ErrorLine
If ER = ERR_FILE_NOT_FOUND Then Resume Recover
If ER = ERR_PATH_NOT_FOUND Then Resume BadDirectory


Resume Quit



Quit:
Print "?Error"; ER; "when "; ErrF; " on line"; EL; "described as "
Print _ErrorMessage$(ER)
End
BadDirectory:
Print "?Directory '"; Target; " does not exist.": End
Error2:
ER = Err: EL = _ErrorLine
Print "?Can't create file "; TargetFile



End

Recover:
Print "File "; TargetFile; " not found, creating."
On Error GoTo Error2
Open TargetFile For Output As #OutF





' Default Version.bi
Data 17
Data $IncludeOnce
Data ' Leave the next line alone,it is automatically adjusted
Data Const Version = "0.0.1"
Data ' Remove the next line if you don't save date
Data $Let VERSIONDATE = TRUE
Data Const VersionDate = "&DATE"
Data ' Remove the next line if you don't save day of week
Data $Let VERSIONDAY = TRUE
Data Const VersionDay = "&DAY"
Data ' This block is only used on Windows
Data $If WIN Then
Data ' The next line will be automatically replaced
Data "$VersionInfo:FileVersion='&VERSION'"
Data "$VersionInfo:LegalCopyright='&COPYRIGHT'"
Data "$VersionInfo:CompanyName='&COMPANYNAME'"
Data "$VersionInfo:InternalName='AutoCommit.bas'"
Data $End If




Sub Help
    Print "AutoCommit - Version "; Version; " of "; VersionDay; ", "; VersionDate




    End
End Sub
