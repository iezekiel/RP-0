//Variables
SET PITCH TO 90.

LOCK STEERING TO HEADING(90, PITCH).
COPYPATH("0:/lib/libSounding.ks","libSounding.ks").
RUNPATH("libSounding.ks").
