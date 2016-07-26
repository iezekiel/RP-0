//Variables
LOCAL targetAzimuth TO 0.
LOCAL targetApoapsis TO 170000.

RUNPATH("ship.ks").
COPYPATH("0:/lib/libLaunchSolid.ks","libLaunchSolid.ks").
RUNPATH("libLaunchSolid.ks",targetAzimuth,targetApoapsis,2).
DELETEPATH("libLaunchSolid.ks").