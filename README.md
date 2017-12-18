# CIF

A parser for Common Interface File (CIF) files as used by Network Rail for transfering schedules from the Integrated Train Planning System (ITPS) to downstream users. This parser targets version 29 of CIF end user specification.

## Format

A CIF file is composed of fixed length (80 bytes) records, the first two bytes denote what the record type is.

### Layout

* Header (HD)
* TIPLOC changes
    * Insertions (TI)
    * Amendments (TA)
    * Deletions (TD)
* Associations (AA)
* Schedule
    * Basic schedule (BS)
    * Basic schedule extra details (BX)
    * Train specific note - not currently used (TN)
    * Origin location (LO)
    * Intermediate location (LI)
    * Changes en Route - optional, preceeds LI (CR)
    * Terminating location (LT)
    * Location specific note - optionally follows LO, LI and LT records - not currently used (LN)
* Trailer record (ZZ)

## Installation

TODO

## Usage

An individual record can be parsed by passing the record as a string to the constructor of the object, for instance to parse a header record:

```d
import cif : Header;

void main()
{
    auto header = Header("HDTPS.UCFCATE.PD1712080812172003DFTTISV       FA081217091218                    ");
}
```
