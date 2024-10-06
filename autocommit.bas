' Uncomment next line for production
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
'Dim Shared ERR_TEXT$(520) ' iDE doesn't like it if dim is in include file
'$Include:'ERRORS.bi'
'$Include:'datesetup.bi'

Const UCa = "A"
Const UCz = "Z"
Const Underscore = Asc("_")
Const Quote = Chr$(34) ' "
Const FALSE = 0
Const TRUE = Not FALSE
Const StdColor = 14 ' Yellow
Const SpecColor = 2 ' Green
Const AltColor = 3 '  Reset to Orange

Dim Shared As String TargetFile
Dim As String TargetDateLine, TargetSourceLine, TargetDayLine
Dim As String GitLocation, GitCommand, ErrF

Dim As Long EL, ER
ReDim As String FileLine(0)

' The following are the valwes this program uses
' If you don't like them, change them and recompile

TargetFile = "Version.bi" '             This is the file we arw going to edit
TargetSourceLine = "Const Version = " + Quote '   This is the value we are going to read and change
TargetDateLine = "Const VersionDate = " + Quote ' Optional field replaced with today's date       \
TargetDayLine = "Const VersionDay = " + Quote '   Optional field replaced with today's day of week


' This only used on Windows
Dim As String TargetFileVersion
TargetFileVersion = "$VersionInfo:FileVersion=" ' Optional field replaced with TargetSourcelinr value

GitLocation = "C:\Program Files\Git\cmd\git.exe " ' Location of Git executable
GitCommand = "commit -m " + Quote + "Revision " '   Start of command to give Git

_PaletteColor AltColor, _RGB32(255, 167, 0) ' Orange
Color StdColor
Dim As String FileLine, Target, VersionText
Dim As Integer InF, OutF, I, S, V, LineCount, NewLineCount, TargetSourceLineCount, TargetDateLineCount, UpdateValue, TargetFileVerCount, TargetDayLineCount, ReadOnly

' Setup for creatimg new file
Read NewLineCount
Dim As String NewLines(NewLineCount)
For I = 1 To NewLineCount
    Read NewLines(I)
Next

On Error GoTo Error1
If _CommandCount <> 0 Then ' Process command
    If Left$(UCase$(Command$(1)), 2) = "-H" Or _
       Left$(UCase$(Command$(1)), 2) = "/H" Or _
       Left$(UCase$(Command$(1)), 3) = "--H" Then Help
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
Color AltColor
Print "�����������������ķ"
Print "� Current Version �"
Print "� "; Right$(Space$(15) + VersionText, 15); " �"
Print "�   Click here    �"
Print "�    to commit    �"
Print "�                 �"
Print "�����������������Ľ"
Color SpecColor: Print "Ready     "
Color AltColor: Print " (Alt-F4 to Close) "
Do
    If _MouseInput Then
        If _MouseButton(1) Then
            ' Do something
            Locate 8, 1
            Color SpecColor: Print "Committing...";
            Color AltColor
            Input I
            ' Print Version No.
            Locate 3, 3

            GoSub Revise
            Print "** DBG701-STUB: Would be COMMIT here"


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
    ReDim _Preserve FileLine(LineCount)
    Line Input #InF, FileLine(LineCount)

    ' Version No. / revision no. should be ahead of any other declarations
    If Not TargetSourceLineCount Then 'Have not found it
        I = InStr(UCase$(FileLine(LineCount)), UCase$(TargetSourceLine))
        If I Then ' Found version
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

            VersionText = VersionText + LTrim$(Str$(UpdateValue))
            FileLine(LineCount) = TargetSourceLine + VersionText + Quote ' Put back new version
            TargetSourceLineCount = LineCount ' Don't need to look again
            _Continue
        End If
    End If ' optional: Compile date, always replaced with todays date
    If Not TargetDateLineCount Then
        If InStr(FileLine(LineCount), TargetDateLine) Then
            FileLine(LineCount) = TargetDateLine + TodaysDate + Quote ' Replace with today
            TargetDateLineCount = LineCount ' Don't need to look again
            _Continue
        End If
    End If ' opional: version number for Windows
    If Not TargetFileVerCount Then
        If InStr(FileLine(LineCount), TargetFileVersion) Then
            FileLine(LineCount) = TargetFileVersion + "'" + VersionText + "'"
            TargetFileVerCount = LineCount
            _Continue
        End If
    End If 'Optional: Day of week
    If Not TargetDayLineCount Then
        If InStr(FileLine(LineCount), TargetDayLine) Then
            FileLine(LineCount) = TargetDayLine + TodaysDay + Quote
            TargetDayLineCount = LineCount
        End If
    End If
Wend
Close #InF

If ReadOnly Then Return

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
Color SpecColor
Print "?Error"; ER; "when "; ErrF; " on line"; EL; "described as "
Print _ErrorMessage$(ER)
End
BadDirectory:
Color SpecColor
Print "?Directory '"; Target; " does not exist."
End
Error2:
Color SpecColor
ER = Err: EL = _ErrorLine
Print "?Can't create file "; TargetFile
Print "due to error "; ERR_TEXT$(ER)


End

Recover:
Print "File "; TargetFile; " not found, creating."
On Error GoTo Error2
$If PROD Then
    Open TargetFile For Output As #OutF
$End If
Info:
Color SpecColor
Print "Please provude initial information:"
Print "  1. Give the: initial version. subversion. build. revision numbers of your program."
Print "  You might not be using all of these, but at least two and at most all 4."
Print "  Each value is separated from the others by a period, e.g. 1.0.5 would mean"
Print "  Version 1, Subversion (or Build) 0,revision 5, while 0.1.3.1 would mean"
Print "  Version 0, Subversion 1, Build 3, Revision 1."
Color AltColor
Input "    Provide Version number value to start: "; VersionText
If VersionText = "" Then VersionText = "0.0.1"

Dim Idate As String
Do
    Color SpecColor
    Print "  Do you want to include date as part of version information, type Yes or No,"
    Print "  Or press 'Enter' for YES."
    Color AltColor
    Print "    Provide date (Yes or No)", Idate
    If Idate = "" Or Left$(UCase$(Idate), 1) = "Y" Then Idate = "Y": Exit Do
    If Left$(UCase$(Idate), 1) = "N" Then Idate = "N": Exit Do
Loop
If Idate = "Y" Then
    Dim iDay As String
    Do
        Color SpecColor
        Print "Do you want to include day of week in version information, "
        Color AltColor
        Input "(Enter=Yes) Yes or No", iDay
        If iDay = "" Or Left$(UCase$(iDay), 1) = "Y" Then iDay = "Y": Exit Do
        If Left$(UCase$(iDay), 1) = "N" Then iDay = "N": Exit Do
    Loop
End If







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

    Color SpecColor
    Print "AutoCommit - Version "; Version; " of "; VersionDay; ", "; VersionDate

    Print " usage:"
    Color AltColor: Print "   autocommit /H ";: Color SpecColor: Print "(or) ";
    Color AltColor: Print "-h  ";: Color SpecColor: Print "(or) ";
    Color AltColor: Print "--h  ";
    Color SpecColor: Print "  This message "
    Print "     (or)"
    Color AltColor: Print "   autocommit [target_diretory]"
    Color SpecColor: Print "     Autocommit will switch to that directory to operate. If no directory"
    Print "     is specified, autocommit will use the directory where it is located."

    Print "     Autocommit will look for a file named '";
    Color AltColor: Print TargetFile;
    Color SpecColor:
    Print "' which it will use"
    Print "     to obtain version information. Then the program will display a small"
    Color AltColor
    Print "     display window ";
    Color SpecColor: Print "which may be clicked upon to have it do a git commit of"
    Print "     that current version of the files in that directory which were changed"
    Print "     and have been added to the files to be tracked by the git source code"
    Print "     management system. If ";
    Color AltColor: Print TargetFile;
    Color SpecColor:
    Print " does not exist in the directory where"
    Print "     Autocommit is located (or the specified directory to use) Autocommit"
    Print "     will create the file and ask for the default parameters."
    Print
    Print "     When the ";: Color AltColor: Print "display window ";
    Color SpecColor: Print "is clicked on, Autocommit will add one to"
    Print "     the revision number and make a request to git of a commit of all files"
    Print "     changed since the last commit."
    End
End Sub

