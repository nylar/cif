module cif.types;

enum NoteType : char
{
    GBTT = 'G',
    WTT = 'W',
}

enum TransactionType : char
{
    new_ = 'N',
    delete_ = 'D',
    revise = 'R',
}

enum UpdateType : char
{
    update = 'U',
    full = 'F',
}
