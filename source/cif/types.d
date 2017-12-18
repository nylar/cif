module cif.types;

enum AssociationType : char
{
    none = ' ',
    passengerUse = 'P',
    operatingUseOnly = 'O',
}

enum NoteType : char
{
    none = ' ',
    GBTT = 'G',
    WTT = 'W',
}

enum TransactionType : char
{
    none = ' ',
    new_ = 'N',
    delete_ = 'D',
    revise = 'R',
}

enum UpdateType : char
{
    none = ' ',
    update = 'U',
    full = 'F',
}
