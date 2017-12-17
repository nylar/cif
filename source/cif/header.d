module cif.header;

import std.datetime.date : Date, DateTime;
import std.conv : to;
import std.string : strip;

import cif.types : UpdateType;
import cif.utils : twoToFourYear;

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

    this(string record)
    {
        this.fileMainframeIdentity = record[2 .. 22];
        this.extractedOn = DateTime(twoToFourYear(to!int(record[26 .. 28])),
                to!int(record[24 .. 26]), to!int(record[22 .. 24]),
                to!int(record[28 .. 30]), to!int(record[30 .. 32]));
        this.currentFileReference = record[32 .. 39];
        this.lastFileReference = strip(record[39 .. 46]);
        this.updateType = to!UpdateType(record[46]);
        this.softwareVersion = record[47];
        this.extractStart = Date(twoToFourYear(to!int(record[52 .. 54])),
                to!int(record[50 .. 52]), to!int(record[48 .. 50]));
        this.extractEnd = Date(twoToFourYear(to!int(record[58 .. 60])),
                to!int(record[56 .. 58]), to!int(record[54 .. 56]));
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
