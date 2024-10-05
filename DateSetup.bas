
Dim Shared As Integer Year, Month, Day, Hour, Minute, Second, Leap
Const Saturday = 0
Const Sunday = Saturday + 1
Const Monday = Sunday + 1
Const Tuesday = Monday + 1
Const Wednesday = Tuesday + 1
Const Thursday = Wednesday + 1
Const Friday = Thursday + 1

Const January = 1, February = 2, March = 3, April = 4, May = 5, June = 6
Const July = 7, August = 8, September = 9, October = 10, November = 11, December = 12
Dim Shared MonthDays(1, December) As Integer, MonthNames(December) As String, DayNames(Friday) As String
Dim D$
D$ = Date$
TheMonth = Val(Mid$(D$, 1, 2))
TheDay = Val(Mid$(D$, 4, 2))
TheYear = Val(Mid$(D$, 7, 4))
Data "January",31,"February",28,"March",31,"April",30,"May",31
Data "June",30,"July",31,"August",31,"September",30
Data "October",31,"November",30,"December",31

Data "Saturday","Sunday","Monday","Tuesday","Wednesday","Thursday","Friday"

For Month = January To December: Read MonthNames(Month), MonthDays(0, Month): Next
For Month = January To December: MonthDays(1, Month) = MonthDays(0, Month): Next ' Leap years
For Day = Saturday To Friday: Read DayNames(Day): Next

MonthDays(1, February) = 29 'Adjust for leap year

Dim YearStart(2020 to 2099) as _byte

