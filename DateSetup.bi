$IncludeOnce
'Option _Explicit
' Alternnative to Zeller's congruence to get today's dsy of week

Const Saturday = 0
Const Sunday = Saturday + 1
Const Monday = Sunday + 1
Const Tuesday = Monday + 1
Const Wednesday = Tuesday + 1
Const Thursday = Wednesday + 1
Const Friday = Thursday + 1

Const January = 1, February = 2, March = 3, April = 4, May = 5, June = 6
Const July = 7, August = 8, September = 9, October = 10, November = 11, December = 12
Dim Shared As Integer Year, Month, Day, TheYear, TheMonth, TheDay, Leap, MonthDays(1, December)
Dim Shared As String TodaysDate, TodaysDay, MonthNames(December), DayNames(Friday)


TodaysDate = Date$
TheMonth = Val(Mid$(TodaysDate, 1, 2))
TheDay = Val(Mid$(TodaysDate, 4, 2))
TheYear = Val(Mid$(TodaysDate, 7, 4))
Data "January",31,"February",28,"March",31,"April",30,"May",31
Data "June",30,"July",31,"August",31,"September",30
Data "October",31,"November",30,"December",31

Data "Saturday","Sunday","Monday","Tuesday","Wednesday","Thursday","Friday"

For Month = January To December: Read MonthNames(Month), MonthDays(0, Month): Next
For Month = January To December: MonthDays(1, Month) = MonthDays(0, Month): Next ' Leap years
For Day = Saturday To Friday: Read DayNames(Day): Next

MonthDays(1, February) = 29 'Adjust for leap year

Data 14,6,0,1,12,4,5,6,10,2: ' 2020 - 2029
Data 3,4,15,0,1,2,13,5,6,0: ' 2030 - 2039
Data 11,3,4,5,16,1,2,3,14,6: ' 2040 - 2049
Data 0,1,12,4,5,6,10,2,3,4: ' 2050 - 2059
Data 15,0,1,2,13,5,6,0,11,3: ' 2060 - 2069
Data 4,5,16,1,2,3,14,6,0,1: ' 2070 - 2079
Data 12,4,5,6,10,2,3,4,15,0: ' 2080 - 2089
Data 1,2,13,5,6,0,11,3,4,5: ' 2090 - 2099

Dim As Integer YearStart(2020 To 2099), DayStart
For Year = 2020 To 2099: Read YearStart(Year): Next
DayStart = YearStart(TheYear) ' Day of week of January 1
If DayStart > 6 Then DayStart = DayStart - 10: Leap = 1
' Now count the days
For Month = January To December
    For Day = 1 To MonthDays(Leap, Month) ' if leap year, uses alternate
        If Month = TheMonth And Day = TheDay Then GoTo DateFound
        DayStart = DayStart + 1
        If DayStart = 7 Then DayStart = 0
    Next
Next
DateFound:
TodaysDate = MonthNames(TheMonth) + Str$(TheDay) + "," + Str$(TheYear)
TodaysDay = DayNames(DayStart)

