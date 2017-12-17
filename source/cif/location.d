module cif.location;

import std.datetime.date : TimeOfDay;
import std.string : strip;
import std.typecons : Nullable;

import cif.utils : parseTime;

struct OriginLocation
{
    string location;
    char suffix;
    TimeOfDay scheduledDeparture;
    TimeOfDay publicDeparture;
    string platform;
    string line;
    string engineeringAllowance;
    string pathingAllowance;
    string activity;
    string performanceAllowance;

    this(string record)
    {
        this.location = strip(record[2 .. 9]);
        this.suffix = record[9];
        this.scheduledDeparture = parseTime(record[10 .. 15]);
        this.publicDeparture = parseTime(record[15 .. 19]);
        this.platform = strip(record[19 .. 22]);
        this.line = strip(record[22 .. 25]);
        this.engineeringAllowance = strip(record[25 .. 27]);
        this.pathingAllowance = strip(record[27 .. 29]);
        this.activity = record[29 .. 41];
        this.performanceAllowance = strip(record[41 .. 43]);
    }

    unittest
    {
        auto line = "LOCREWE   1302 13023         TB                                                 ";
        const OriginLocation origin = OriginLocation(line);

        assert(origin.location == "CREWE");
        assert(origin.suffix == ' ');
        assert(origin.scheduledDeparture == TimeOfDay(13, 2, 0));
        assert(origin.publicDeparture == TimeOfDay(13, 2, 0));
        assert(origin.platform == "3");
        assert(origin.line == "");
        assert(origin.engineeringAllowance == "");
        assert(origin.pathingAllowance == "");
        assert(origin.activity == "TB          ");
        assert(origin.performanceAllowance == "");
    }
}

struct IntermediateLocation
{
    string location;
    char suffix;
    Nullable!TimeOfDay scheduledArrival;
    Nullable!TimeOfDay scheduledDeparture;
    Nullable!TimeOfDay scheduledPass;
    TimeOfDay publicArrival;
    TimeOfDay publicDeparture;
    string platform;
    string line;
    string path;
    string activity;
    string engineeringAllowance;
    string pathingAllowance;
    string performanceAllowance;

    this(string record)
    {
        this.location = strip(record[2 .. 9]);
        this.suffix = record[9];

        if (record[10] != ' ')
        {
            this.scheduledArrival = parseTime(record[10 .. 15]);
        }

        if (record[15] != ' ')
        {
            this.scheduledDeparture = parseTime(record[15 .. 20]);
        }

        if (record[20] != ' ')
        {
            this.scheduledDeparture = parseTime(record[20 .. 25]);
        }

        this.publicArrival = parseTime(record[25 .. 29]);
        this.publicDeparture = parseTime(record[29 .. 33]);
        this.platform = strip(record[33 .. 36]);
        this.line = strip(record[36 .. 39]);
        this.path = strip(record[39 .. 42]);
        this.activity = record[42 .. 54];
        this.engineeringAllowance = strip(record[54 .. 56]);
        this.pathingAllowance = strip(record[56 .. 58]);
        this.performanceAllowance = strip(record[58 .. 60]);
    }

    unittest
    {
        auto line = "LIMKNSCEN 1124 1125      112411255  SL FL T           1                         ";
        const IntermediateLocation intermediate = IntermediateLocation(line);

        assert(intermediate.location == "MKNSCEN");
        assert(intermediate.suffix == ' ');
        assert(intermediate.scheduledArrival == TimeOfDay(11, 24, 0));
        assert(intermediate.scheduledDeparture == TimeOfDay(11, 25, 0));
        assert(intermediate.scheduledPass.isNull());
        assert(intermediate.publicArrival == TimeOfDay(11, 24, 0));
        assert(intermediate.publicDeparture == TimeOfDay(11, 25, 0));
        assert(intermediate.platform == "5");
        assert(intermediate.line == "SL");
        assert(intermediate.path == "FL");
        assert(intermediate.activity == "T           ");
        assert(intermediate.engineeringAllowance == "1");
        assert(intermediate.pathingAllowance == "");
        assert(intermediate.performanceAllowance == "");
    }
}

struct TerminatingLocation
{
    string location;
    char suffix;
    TimeOfDay scheduledArrival;
    TimeOfDay publicArrival;
    string platform;
    string path;
    string activity;

    this(string record)
    {
        this.location = strip(record[2 .. 9]);
        this.suffix = record[9];
        this.scheduledArrival = parseTime(record[10 .. 15]);
        this.publicArrival = parseTime(record[15 .. 19]);
        this.platform = strip(record[19 .. 22]);
        this.path = strip(record[22 .. 25]);
        this.activity = record[25 .. 37];
    }

    unittest
    {
        auto line = "LTSTONEGS 1531 1531      TF                                                     ";
        const TerminatingLocation terminus = TerminatingLocation(line);

        assert(terminus.location == "STONEGS");
        assert(terminus.suffix == ' ');
        assert(terminus.scheduledArrival == TimeOfDay(15, 31, 0));
        assert(terminus.publicArrival == TimeOfDay(15, 31, 0));
        assert(terminus.platform == "");
        assert(terminus.path == "");
        assert(terminus.activity == "TF          ");
    }
}
