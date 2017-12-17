module cif.routechange;

import std.conv : to;
import std.string : strip;

struct RouteChange
{
    string location;
    char suffix;
    string category;
    string identity;
    string headcode;
    char courseIndicator;
    string serviceCode;
    char portionId;
    string powerType;
    string timingLoad;
    int speed;
    string operatingCharacteristics;
    char seatingClass;
    char sleepers;
    char reservations;
    char connectionIndicator;
    string cateringCode;
    string serviceBranding;
    string tractionClass;
    string uicCode;
    string reservationSystemId;

    this(string record)
    {
        this.location = strip(record[2 .. 9]);
        this.suffix = record[9];
        this.category = record[10 .. 12];
        this.identity = record[12 .. 16];
        this.headcode = strip(record[16 .. 20]);
        this.courseIndicator = record[20];
        this.serviceCode = record[21 .. 29];
        this.portionId = record[29];
        this.powerType = record[30 .. 33];
        this.timingLoad = strip(record[33 .. 37]);

        if (record[37] != ' ')
        {
            this.speed = to!int(record[37 .. 40]);
        }

        this.operatingCharacteristics = record[40 .. 46];
        this.seatingClass = record[46];
        this.sleepers = record[47];
        this.reservations = record[48];
        this.connectionIndicator = record[49];
        this.cateringCode = strip(record[50 .. 54]);
        this.serviceBranding = strip(record[54 .. 58]);
        this.tractionClass = strip(record[58 .. 62]);
        this.uicCode = strip(record[62 .. 67]);
        this.reservationSystemId = strip(record[67 .. 75]);
    }

    unittest
    {
        auto line = "CRBRSTLTM XX1B048508125460001 DMUE   090      S S                  GW850800     ";
        const RouteChange changesEnRoute = RouteChange(line);

        assert(changesEnRoute.location == "BRSTLTM");
        assert(changesEnRoute.suffix == ' ');
        assert(changesEnRoute.category == "XX");
        assert(changesEnRoute.identity == "1B04");
        assert(changesEnRoute.headcode == "8508");
        assert(changesEnRoute.courseIndicator == '1');
        assert(changesEnRoute.serviceCode == "25460001");
        assert(changesEnRoute.portionId == ' ');
        assert(changesEnRoute.powerType == "DMU");
        assert(changesEnRoute.timingLoad == "E");
        assert(changesEnRoute.speed == 90);
        assert(changesEnRoute.operatingCharacteristics == "      ");
        assert(changesEnRoute.seatingClass == 'S');
        assert(changesEnRoute.sleepers == ' ');
        assert(changesEnRoute.reservations == 'S');
        assert(changesEnRoute.connectionIndicator == ' ');
        assert(changesEnRoute.cateringCode == "");
        assert(changesEnRoute.serviceBranding == "");
        assert(changesEnRoute.tractionClass == "");
        assert(changesEnRoute.uicCode == "");
        assert(changesEnRoute.reservationSystemId == "GW850800");
    }
}
