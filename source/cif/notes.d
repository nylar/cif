module cif.notes;

import std.string : strip;

enum NoteType : char
{
    GBTT = 'G',
    WTT = 'W',
}

private NoteType fromChar(char note)
{
    final switch (note)
    {
    case 'G':
        return NoteType.GBTT;
    case 'W':
        return NoteType.WTT;
    }
}

unittest
{
    assert(fromChar('G') == NoteType.GBTT);
    assert(fromChar('W') == NoteType.WTT);
}

struct TrainNote
{
    NoteType type;
    string note;

    this(string record)
    {
        this.type = fromChar(record[2]);
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
        this.type = fromChar(record[2]);
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
