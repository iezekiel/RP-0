RUNPATH("ship.ks").

//Variables
SET PITCH TO 90.

COPYPATH("0:/lib/libSounding.ks","libSounding.ks").
SET SHIP:CONTROL:MAINTHROTTLE TO 1.0.
LOCK STEERING TO HEADING(90, PITCH).
WAIT 1.
STAGE.
WAIT 3.
RUNPATH("libSounding.ks").