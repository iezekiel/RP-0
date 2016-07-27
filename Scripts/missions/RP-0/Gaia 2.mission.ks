RUNPATH("ship.ks").

//Variables
LOCAL targetInclination IS 28.6.
LOCAL targetApoapsis IS 690000.
LOCAL targetPeriapsis IS 500000.
LOCAL targetLAN IS 0.

IF targetLAN <> 0 {
    COPYPATH("0:/lib/libWaitForLAN.ks","libWaitForLAN.ks").
    RUNPATH("libWaitForLAN.ks",targetLAN).
    DELETEPATH("libWaitForLAN.ks").
}

COPYPATH("0:/lib/libLaunchATM.ks","libLaunchATM.ks").
RUNPATH("libLaunchATM.ks", targetInclination).
DELETEPATH("libLaunchATM.ks").
COPYPATH("0:/lib/libOrbitalManus.ks","libOrbitalManus.ks").
COPYPATH("0:/lib/libNode.ks","libNode.ks").

// Orbital operations
RUNONCEPATH("libOrbitalManus.ks").
WAIT 5.
ChangeApoapsis(targetApoapsis).
WAIT 5.
RUNPATH("libNode.ks").
WAIT 5.
ChangePeriapsis(targetPeriapsis).
WAIT 5.
RUNPATH("libNode.ks").