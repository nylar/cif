module cif.utils;

import std.algorithm : filter, map;
import std.array : array;
import std.datetime.date : DayOfWeek;
import std.range : enumerate;

package int twoToFourYear(int year)
{
    return year >= 60 ? 1900 + year : 2000 + year;
}

unittest
{
    assert(twoToFourYear(80) == 1980);
    assert(twoToFourYear(12) == 2012);
}

private DayOfWeek[] weekDays = [
    DayOfWeek.mon, DayOfWeek.tue, DayOfWeek.wed, DayOfWeek.thu, DayOfWeek.fri,
    DayOfWeek.sat, DayOfWeek.sun
];

package DayOfWeek[] daysRunning(string days)
{
    return days.enumerate.filter!(a => a.value == '1').map!(a => weekDays[a.index]).array();
}

unittest
{
    assert(daysRunning("1111100") == [DayOfWeek.mon, DayOfWeek.tue,
            DayOfWeek.wed, DayOfWeek.thu, DayOfWeek.fri]);

    assert(daysRunning("0000011") == [DayOfWeek.sat, DayOfWeek.sun]);
}
