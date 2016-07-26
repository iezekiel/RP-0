// Sounding Rockets Script v1.0.0
// Constandinos Iezekiel 2016

COPYPATH("0:/lib/libLaunchUtils.ks","libLaunchUtils.ks").
RUNONCEPATH("libLaunchUtils.ks").

SET SHIP:CONTROL:MAINTHROTTLE TO 1.0.
WAIT 1.
STAGE.
WAIT 0.1.
PRINT "Lift Off!".

UNTIL ETA:APOAPSIS < 1 and altitude > 1000 {
	FLAMEOUT(0.1).
	ACTIVATORS().
	WAIT 0.1.
}
SET WARP TO 0.
PRINT"Apoapsis reached.".
