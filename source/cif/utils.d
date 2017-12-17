module cif.utils;

import std.algorithm : filter, map;
import std.array : array;
import std.conv : to;
import std.datetime.date : DayOfWeek, TimeOfDay;
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

package TimeOfDay parseTime(string time)
{
    int hour = to!int(time[0 .. 2]);
    int minute = to!int(time[2 .. 4]);

    if (time.length == 4)
    {
        return TimeOfDay(hour, minute, 0);
    }

    return TimeOfDay(hour, minute, time[4] == 'H' ? 30 : 0);
}

unittest
{
    assert(parseTime("1536H") == TimeOfDay(15, 36, 30));
    assert(parseTime("1215 ") == TimeOfDay(12, 15, 0));
    assert(parseTime("1340") == TimeOfDay(13, 40, 0));
}
