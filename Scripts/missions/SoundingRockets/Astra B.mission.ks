//Variables
SET PITCH TO 90.

COPYPATH("0:/lib/libSounding.ks","libSounding.ks").
LOCK STEERING TO HEADING(90, PITCH).
RUNPATH("libSounding.ks").
