module cif.header;

import std.datetime.date : Date, DateTime;
import std.conv : to;
import std.string : strip;

import cif.utils : twoToFourYear;

private nothrow @safe pure UpdateType fromChar(char updateType)
{
    final switch (updateType)
    {
    case 'U':
        return UpdateType.update;
    case 'F':
        return UpdateType.full;
    }
}

unittest
{
    assert(fromChar('U') == UpdateType.update);
    assert(fromChar('F') == UpdateType.full);
}

enum UpdateType : char
{
    update = 'U',
    full = 'F',
}

struct Header
{
    string fileMainframeIdentity;
    DateTime extractedOn;
    string currentFileReference;
    string lastFileReference;
    UpdateType updateType;
    char softwareVersion;
    Date extractStart;
    Date extractEnd;

    this(string line)
    {
        this.fileMainframeIdentity = line[2 .. 22];
        this.extractedOn = DateTime(twoToFourYear(to!int(line[26 .. 28])),
                to!int(line[24 .. 26]), to!int(line[22 .. 24]),
                to!int(line[28 .. 30]), to!int(line[30 .. 32]));
        this.currentFileReference = line[32 .. 39];
        this.lastFileReference = strip(line[39 .. 46]);
        this.updateType = fromChar(line[46]);
        this.softwareVersion = line[47];
        this.extractStart = Date(twoToFourYear(to!int(line[52 .. 54])),
                to!int(line[50 .. 52]), to!int(line[48 .. 50]));
        this.extractEnd = Date(twoToFourYear(to!int(line[58 .. 60])),
                to!int(line[56 .. 58]), to!int(line[54 .. 56]));
    }

    unittest
    {
        auto line = "HDTPS.UCFCATE.PD1712080812172003DFTTISV       FA081217091218                    ";
        const Header header = Header(line);

        assert(header.fileMainframeIdentity == "TPS.UCFCATE.PD171208");
        assert(header.extractedOn == DateTime(2017, 12, 8, 20, 3));
        assert(header.currentFileReference == "DFTTISV");
        assert(header.lastFileReference == "");
        assert(header.updateType == UpdateType.full);
        assert(header.softwareVersion == 'A');
        assert(header.extractStart == Date(2017, 12, 8));
        assert(header.extractEnd == Date(2018, 12, 9));
    }
}
