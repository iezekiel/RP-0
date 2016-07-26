//Variables
SET PITCH TO 90.

COPYPATH("0:/lib/libSounding.ks","libSounding.ks").
COPYPATH("0:/lib/libRealChute.ks","libRealChute.ks").
LOCK STEERING TO HEADING(90, PITCH).
RUNPATH("libSounding.ks").
RUNPATH ("libRealChute.ks","arm parachute").
