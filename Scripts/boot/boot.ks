// Boot file

@LAZYGLOBAL OFF.
WAIT 5.
CORE:PART:GETMODULE("kOSProcessor"):DOEVENT("Open Terminal").
SET TERMINAL:HEIGHT TO 24.
SET TERMINAL:WIDTH TO 42.
SET TERMINAL:BRIGHTNESS TO 0.8.
SET TERMINAL:CHARHEIGHT TO 10.

LOCAL shipFile IS CORE:TAG + ".ship.ks".
LOCAL missionFile IS SHIP:NAME + ".mission.ks".

CLEARSCREEN.
IF SHIP:STATUS = "PRELAUNCH" {
    IF ADDONS:RT:HASCONNECTION(SHIP) {
        COPYPATH("0:/missions/RP-0/"+ missionFile,"mission.ks").
        COPYPATH("0:/ships/RP-0/"+ shipFile,"ship.ks").
        RUNPATH("mission.ks").
    }
}