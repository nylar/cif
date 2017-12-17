module cif.basicschedule;

import std.conv : to;
import std.datetime.date : Date, DayOfWeek;
import std.string : strip;

import cif.types : TransactionType;
import cif.utils : daysRunning, twoToFourYear;

struct BasicSchedule
{
    TransactionType transactionType;
    string trainUid;
    Date start;
    Date end;
    DayOfWeek[] days;
    char bankHolidayRunning;
    char status;
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
    char stpIndicator;

    this(string line)
    {
        this.transactionType = to!TransactionType(line[2]);
        this.trainUid = line[3 .. 9];
        this.start = Date(twoToFourYear(to!int(line[9 .. 11])),
                to!int(line[11 .. 13]), to!int(line[13 .. 15]));
        this.end = Date(twoToFourYear(to!int(line[15 .. 17])),
                to!int(line[17 .. 19]), to!int(line[19 .. 21]));
        this.days = daysRunning(line[21 .. 28]);
        this.bankHolidayRunning = line[28];
        this.status = line[29];
        this.category = line[30 .. 32];
        this.identity = line[32 .. 36];
        this.headcode = strip(line[36 .. 40]);
        this.courseIndicator = line[40];
        this.serviceCode = line[41 .. 49];
        this.portionId = line[49];
        this.powerType = line[50 .. 53];
        this.timingLoad = strip(line[53 .. 57]);

        if (line[57] != ' ')
        {
            this.speed = to!int(line[57 .. 60]);
        }

        this.operatingCharacteristics = line[60 .. 66];
        this.seatingClass = line[66];
        this.sleepers = line[67];
        this.reservations = line[68];
        this.connectionIndicator = line[69];
        this.cateringCode = strip(line[70 .. 74]);
        this.serviceBranding = strip(line[74 .. 78]);
        this.stpIndicator = line[79];
    }

    unittest
    {
        auto line = "BSNP642691712111805181111100 PXX1N865032122209000 EMU350 100      B S          P";
        const BasicSchedule basicSchedule = BasicSchedule(line);

        assert(basicSchedule.transactionType == TransactionType.new_);
        assert(basicSchedule.trainUid == "P64269");
        assert(basicSchedule.start == Date(2017, 12, 11));
        assert(basicSchedule.end == Date(2018, 5, 18));
        assert(basicSchedule.days == [DayOfWeek.mon, DayOfWeek.tue,
                DayOfWeek.wed, DayOfWeek.thu, DayOfWeek.fri]);
        assert(basicSchedule.bankHolidayRunning == ' ');
        assert(basicSchedule.status == 'P');
        assert(basicSchedule.category == "XX");
        assert(basicSchedule.identity == "1N86");
        assert(basicSchedule.headcode == "5032");
        assert(basicSchedule.courseIndicator == '1');
        assert(basicSchedule.serviceCode == "22209000");
        assert(basicSchedule.portionId == ' ');
        assert(basicSchedule.powerType == "EMU");
        assert(basicSchedule.timingLoad == "350");
        assert(basicSchedule.speed == 100);
        assert(basicSchedule.operatingCharacteristics == "      ");
        assert(basicSchedule.seatingClass == 'B');
        assert(basicSchedule.sleepers == ' ');
        assert(basicSchedule.reservations == 'S');
        assert(basicSchedule.connectionIndicator == ' ');
        assert(basicSchedule.cateringCode == "");
        assert(basicSchedule.serviceBranding == "");
        assert(basicSchedule.stpIndicator == 'P');
    }
}

struct BasicScheduleExtra
{
    string tractionClass;
    string uicClass;
    string atocCode;
    char applicableTimetableCode;
    string reservationSystemId;
    char dataSource;

    this(string line)
    {
        this.tractionClass = strip(line[2 .. 6]);
        this.uicClass = strip(line[6 .. 11]);
        this.atocCode = line[11 .. 13];
        this.applicableTimetableCode = line[13];
        this.reservationSystemId = line[14 .. 22];
        this.dataSource = line[22];
    }

    unittest
    {
        auto line = "BX         LMYLM503200                                                          ";
        const BasicScheduleExtra extra = BasicScheduleExtra(line);

        assert(extra.tractionClass == "");
        assert(extra.uicClass == "");
        assert(extra.atocCode == "LM");
        assert(extra.applicableTimetableCode == 'Y');
        assert(extra.reservationSystemId == "LM503200");
        assert(extra.dataSource == ' ');
    }
}
