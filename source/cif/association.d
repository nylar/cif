module cif.association;

import std.conv : to;
import std.datetime.date : Date, DayOfWeek;
import std.string : strip;

import cif.types : AssociationType, TransactionType;
import cif.utils : daysRunning, twoToFourYear;

struct Association
{
    TransactionType transactionType;
    string mainTrainUID;
    string associatedTrainUID;
    Date start;
    Date end;
    DayOfWeek[] days;
    string category;
    char dateIndicator;
    string location;
    char baseLocationSuffix;
    char assocLocationSuffix;
    char diagramType = 'T';
    AssociationType type;
    char stpIndicator;

    this(string record)
    {
        this.transactionType = to!TransactionType(record[2]);
        this.mainTrainUID = record[3 .. 9];
        this.associatedTrainUID = record[9 .. 15];
        this.start = Date(twoToFourYear(to!int(record[15 .. 17])),
                to!int(record[17 .. 19]), to!int(record[19 .. 21]));
        this.end = Date(twoToFourYear(to!int(record[21 .. 23])),
                to!int(record[23 .. 25]), to!int(record[25 .. 27]));
        this.days = daysRunning(record[27 .. 34]);
        this.category = record[34 .. 36];
        this.dateIndicator = record[36];
        this.location = strip(record[37 .. 44]);
        this.baseLocationSuffix = record[44];
        this.assocLocationSuffix = record[45];
        this.diagramType = record[46];
        this.type = to!AssociationType(record[47]);
        this.stpIndicator = record[79];
    }

    unittest
    {
        auto line = "AANG72112G740651712161805190000010VVSHORSHAM  TP                               P";
        const Association association = Association(line);

        assert(association.transactionType == TransactionType.new_);
        assert(association.mainTrainUID == "G72112");
        assert(association.associatedTrainUID == "G74065");
        assert(association.start == Date(2017, 12, 16));
        assert(association.end == Date(2018, 5, 19));
        assert(association.days == [DayOfWeek.sat]);
        assert(association.category == "VV");
        assert(association.dateIndicator == 'S');
        assert(association.location == "HORSHAM");
        assert(association.baseLocationSuffix == ' ');
        assert(association.assocLocationSuffix == ' ');
        assert(association.diagramType == 'T');
        assert(association.type == AssociationType.passengerUse);
        assert(association.stpIndicator == 'P');
    }
}
