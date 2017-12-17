module cif.tiploc;

import std.string : strip;

struct TiplocInsert
{
    string tiplocCode;
    string capitalsIdentification;
    string nationalLocationCode;
    char checkCharacter;
    string tpsDescription;
    string stanox;
    string postOfficeLocationCode;
    string crsCode;
    string description;

    this(string record)
    {
        this.tiplocCode = strip(record[2 .. 9]);
        this.capitalsIdentification = record[9 .. 11];
        this.nationalLocationCode = record[11 .. 17];
        this.checkCharacter = record[17];
        this.tpsDescription = strip(record[18 .. 44]);
        this.stanox = record[44 .. 49];
        this.postOfficeLocationCode = record[49 .. 53];
        this.crsCode = record[53 .. 56];
        this.description = strip(record[56 .. 72]);
    }

    unittest
    {
        auto line = "TIBHAMNWS40112700EBIRMINGHAM NEW STREET     656302810BHMBIRMINGHAM N ST         ";
        const TiplocInsert inserted = TiplocInsert(line);

        assert(inserted.tiplocCode == "BHAMNWS");
        assert(inserted.capitalsIdentification == "40");
        assert(inserted.nationalLocationCode == "112700");
        assert(inserted.checkCharacter == 'E');
        assert(inserted.tpsDescription == "BIRMINGHAM NEW STREET");
        assert(inserted.stanox == "65630");
        assert(inserted.postOfficeLocationCode == "2810");
        assert(inserted.crsCode == "BHM");
        assert(inserted.description == "BIRMINGHAM N ST");
    }
}

struct TiplocAmend
{
    string tiplocCode;
    string capitalsIdentification;
    string nationalLocationCode;
    char checkCharacter;
    string tpsDescription;
    string stanox;
    string postOfficeLocationCode;
    string crsCode;
    string description;
    string newTiplocCode;

    this(string record)
    {
        this.tiplocCode = strip(record[2 .. 9]);
        this.capitalsIdentification = record[9 .. 11];
        this.nationalLocationCode = record[11 .. 17];
        this.checkCharacter = record[17];
        this.tpsDescription = strip(record[18 .. 44]);
        this.stanox = record[44 .. 49];
        this.postOfficeLocationCode = record[49 .. 53];
        this.crsCode = record[53 .. 56];
        this.description = strip(record[56 .. 72]);
        this.newTiplocCode = strip(record[72 .. 79]);
    }

    unittest
    {
        auto line = "TABHAMNWS40112700EBIRMINGHAM NEW STREET     656302810BHMBIRMINGHAM N ST BHAMNWS ";
        const TiplocAmend amended = TiplocAmend(line);

        assert(amended.tiplocCode == "BHAMNWS");
        assert(amended.capitalsIdentification == "40");
        assert(amended.nationalLocationCode == "112700");
        assert(amended.checkCharacter == 'E');
        assert(amended.tpsDescription == "BIRMINGHAM NEW STREET");
        assert(amended.stanox == "65630");
        assert(amended.postOfficeLocationCode == "2810");
        assert(amended.crsCode == "BHM");
        assert(amended.description == "BIRMINGHAM N ST");
        assert(amended.newTiplocCode == "BHAMNWS");
    }
}

struct TiplocDelete
{
    string tiplocCode;

    this(string record)
    {
        this.tiplocCode = strip(record[2 .. 9]);
    }

    unittest
    {
        auto line = "TDBHAMNWS                                                                       ";
        const TiplocDelete deleted = TiplocDelete(line);

        assert(deleted.tiplocCode == "BHAMNWS");
    }
}
