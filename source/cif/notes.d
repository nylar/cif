module cif.notes;

import std.conv : to;
import std.string : strip;

enum NoteType : char
{
    GBTT = 'G',
    WTT = 'W',
}

struct TrainNote
{
    NoteType type;
    string note;

    this(string record)
    {
        this.type = to!NoteType(record[2]);
        this.note = strip(record[3 .. $]);
    }

    unittest
    {
        auto line = "TNGA little note                                                                ";
        const TrainNote trainNote = TrainNote(line);

        assert(trainNote.type == NoteType.GBTT);
        assert(trainNote.note == "A little note");
    }
}

struct LocationNote
{
    NoteType type;
    string note;

    this(string record)
    {
        this.type = to!NoteType(record[2]);
        this.note = strip(record[3 .. $]);
    }

    unittest
    {
        auto line = "LNGA little note                                                                ";
        const LocationNote locationNote = LocationNote(line);

        assert(locationNote.type == NoteType.GBTT);
        assert(locationNote.note == "A little note");
    }
}
