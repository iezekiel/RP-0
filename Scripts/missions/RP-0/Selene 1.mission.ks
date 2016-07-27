RUNPATH("ship.ks").

SET target TO ("Moon").

COPYPATH("0:/lib/libLaunchWindow.ks","libLaunchWindow.ks").
RUNPATH("libLaunchWindow.ks").
DELETEPATH("libLaunchWindow.ks").

COPYPATH("0:/lib/libLaunchATM.ks","libLaunchATM.ks").
RUNPATH("libLaunchATM.ks",TARGET:ORBIT:INCLINATION).
DELETEPATH("libLaunchATM.ks").
DELETEPATH("ship.ks").

// Set Hohmann tranfer to target but need custom manual edits afterwards
COPYPATH("0:/lib/libOrbitalManus.ks","libOrbitalManus.ks").
RUNONCEPATH("libOrbitalManus.ks").
WAIT 5.
Hohmann().