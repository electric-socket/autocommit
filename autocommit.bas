' Unciomment next line for production
'$let prod=1
Option _Explicit
' Autocommit by Paul Robinson
' Thursday, October 5, 2024

' This program opens a configuration file located in either the current directory
' (The one this program was invoked from) or the specified directory in the command line.
' We read the version number including build number (the last dotted decimal)
' bump it up by 1, rewrite it back, then do a commit to the git repository.
' Wait until clicked on, then do it again.

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
TargetSourceLine = "Const Version = " + Quote '   This is the value we are going to read and change
TargetDateLine = "Const VersionDate =" ' Optional field replaced with today's date       \
TargetDayLine = "Const VersionDay =" '   Optional field replaced with today's day of week


' This only used on Windows
Dim As String TargetFileVersion
TargetFileVersion = "$VersionInfo:FileVersion=" ' Optional field replaced with TargetSourcelinr value

GitLocation = "C:\Program Files\Git\cmd\git.exe " ' Location of Git executable
GitCommand = "commit -m " + Quote + "Revision " '   Start of command to give Git

_PaletteColor 3, _RGB32(255, 167, 0) ' Orange
Color 14 ' Yellow
Dim As String FileLine, Target, VersionText
Dim As Integer InF, OutF, I, S, V, LineCount, NewLineCount, TargetSourceLineCount, TargetDateLineCount, UpdateValue, TargetFileVerCount, TargetDayLineCount, ReadOnly, Temp

' Setup for creatimg new file
Read NewLineCount
Dim As String NewLines(NewLineCount)
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

'Initialize values
ReadOnly = TRUE
GoSub Revise
' Start the display
Start:
Width 20, 10
ReadOnly = FALSE

Cls

Print "ÖÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ·"
Print "º Current Version º"
Print "º "; Right$(Space$(16) + VersionText, 16); " º"
Print "º   Click here    º"
Print "º    to commit    º"
Print "º                 º"
Print "ÓÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ½"
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

            GoSub Revise
            Print "Would be"


            'restore after commit
            GoTo Start
        End If
    End If
    'Exit Via ALT-F4
Loop ' Until InKey$ <> ""
End

Revise:

'Revise version number
ErrF = "Opening version file"

' When this finishes:

'  if readonly, file is not rewrtten
'  VersionText is either
'   the current revision number (if readonly)
'     or
'   the new revision number


Open TargetFile For Input As #InF
Print "Opening Version Info file"
TargetSourceLineCount = 0
TargetDateLineCount = 0
TargetFileVerCount = 0
TargetDayLineCount = 0
LineCount = 0
While Not EOF(InF)
    LineCount = LineCount + 1
    $If PROD = UNDEFINED Then
        Print "DBG01";
        If ReadOnly Then Print " (R/O)";
        Print "-reading record #"; LineCount
    $End If
    ReDim _Preserve FileLine(LineCount)
    Line Input #InF, FileLine(LineCount)
    $If PROD = UNDEFINED Then
        Print "DBG11-Linecount="; LineCount
        Print "DBG12-FileLine(LineCount)="; FileLine(LineCount)
    $End If

    ' Version No. / revision no. should be ahead of any other declarations
    If Not TargetSourceLineCount Then 'Have not found it
        $If PROD = UNDEFINED Then
            Print "DBG02-target check"
        $End If
        I = InStr(UCase$(FileLine(LineCount)), UCase$(TargetSourceLine))
        $If PROD = UNDEFINED Then
            Print "DBG21-TargetSourceLine="; TargetSourceLine
        $End If

        If I Then ' Found version
            $If PROD = UNDEFINED Then
                Print "DBG23-Found ver"
            $End If
            ' Extract version number
            I = I + Len(TargetSourceLine) ' Char after first quote
            V = InStr(I, FileLine(LineCount), Quote) - 1 ' Char before last quote
            S = V - I + 1 ' Length, i.e. Size of field

            VersionText = Mid$(FileLine(LineCount), I, S) ' Pull off revision strimg
            I = _InStrRev(VersionText, ".") ' Find last period
            Dim As String Revision
            Revision = Mid$(VersionText, I + 1, Len(VersionText))
            VersionText = Left$(VersionText, I) ' All through last period
            UpdateValue = Val(Revision) ' Extract revision value
            If Not ReadOnly Then UpdateValue = UpdateValue + 1 ' Imcrement revision no.
            ' No longer need updatelevel, reuse
            $If PROD = UNDEFINED Then
                Print "DBG26-UpdateValue="; UpdateValue
            $End If

            VersionText = VersionText + LTrim$(Str$(UpdateValue))
            FileLine(LineCount) = TargetSourceLine + VersionText + Quote ' Put back new version
            TargetSourceLineCount = LineCount ' Don't need to look again
            _Continue
        End If
    End If ' optional: Compile date, always replaced with todays date
    If Not TargetDateLineCount Then
        $If PROD = UNDEFINED Then
            Print "DBG03-date check"
        $End If
        If InStr(FileLine(LineCount), TargetDateLine) Then
            $If PROD = UNDEFINED Then
                Print "DBG31-TodaysDate="; TodaysDate
            $End If

            FileLine(LineCount) = TargetDateLine + Quote + TodaysDate + Quote ' Replace with today
            TargetDateLineCount = LineCount ' Don't need to look again
            _Continue
        End If
    End If ' opional: version number for Windows
    If Not TargetFileVerCount Then
        $If PROD = UNDEFINED Then
            Print "DBG04-opt windows ver"
        $End If
        $If PROD = UNDEFINED Then
            Print "DBG41-versiontext="; VersionText
        $End If
        If InStr(FileLine(LineCount), TargetFileVersion) Then
            FileLine(LineCount) = TargetFileVersion + "'" + VersionText + "'"
            TargetFileVerCount = LineCount
            _Continue
        End If
    End If 'Optional: Day of week
    If Not TargetDayLineCount Then
        $If PROD = UNDEFINED Then
            Print "DBG05-opt day"
        $End If
        If InStr(FileLine(LineCount), TargetDayLine) Then
            $If PROD = UNDEFINED Then
                Print "DBG51-TodaysDay="; TodaysDay
            $End If

            FileLine(LineCount) = TargetDayLine + Quote + TodaysDay + Quote
            TargetDayLineCount = LineCount
        End If
    End If
    $If PROD = UNDEFINED Then
        Print "DBG10A-Linecount="; LineCount
        Print "DBG10-Pause"
        Input I
    $End If

Wend
Close #InF

If ReadOnly Then Return
$If PROD = UNDEFINED Then
    Print "DBG06-rewrite"
$End If

' rewrite change
Open TargetFile For Output As #OutF
For I = 1 To LineCount
    Print #OutF, FileLine(I)
Next
Close #OutF


Return



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
Data "$VersionInfo:InternalName='&INTERNALNAME'"
Data $End If




Sub Help
    Print "AutoCommit - Version "; Version; " of "; VersionDay; ", "; VersionDate




    End
End Sub
