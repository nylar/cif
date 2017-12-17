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

    this(string line)
    {
        this.location = strip(line[2 .. 9]);
        this.suffix = line[9];
        this.category = line[10 .. 12];
        this.identity = line[12 .. 16];
        this.headcode = strip(line[16 .. 20]);
        this.courseIndicator = line[20];
        this.serviceCode = line[21 .. 29];
        this.portionId = line[29];
        this.powerType = line[30 .. 33];
        this.timingLoad = strip(line[33 .. 37]);

        if (line[37] != ' ')
        {
            this.speed = to!int(line[37 .. 40]);
        }

        this.operatingCharacteristics = line[40 .. 46];
        this.seatingClass = line[46];
        this.sleepers = line[47];
        this.reservations = line[48];
        this.connectionIndicator = line[49];
        this.cateringCode = strip(line[50 .. 54]);
        this.serviceBranding = strip(line[54 .. 58]);
        this.tractionClass = strip(line[58 .. 62]);
        this.uicCode = strip(line[62 .. 67]);
        this.reservationSystemId = strip(line[67 .. 75]);
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
