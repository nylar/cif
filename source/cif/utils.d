module cif.utils;

package int twoToFourYear(int year)
{
    return year >= 60 ? 1900 + year : 2000 + year;
}

unittest
{
    assert(twoToFourYear(80) == 1980);
    assert(twoToFourYear(12) == 2012);
}
