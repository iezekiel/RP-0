// Launch for Atmo Script v1.0.0
// Constandinos Iezekiel
// Original Script https://www.reddit.com/r/Kos/comments/4oswqg/i_wrote_a_launch_script_for_rorp0_based_on/

PARAMETER targetInclination IS 28.5.

COPYPATH("0:/lib/libLaunchUtils.ks","libLaunchUtils.ks").
RUNONCEPATH("libLaunchUtils.ks").

SET launchLoc to SHIP:GEOPOSITION.
SET initAzimuth TO arcsin(max(min(cos(targetInclination) / cos(launchLoc:LAT),1),-1)).
SET targetOrbitSpeed TO SQRT(SHIP:BODY:MU / (200000+SHIP:BODY:RADIUS)).
SET rotvelx to targetOrbitSpeed*sin(initAzimuth) - (6.2832*SHIP:BODY:RADIUS/SHIP:BODY:ROTATIONPERIOD).
SET rotvely to targetOrbitSpeed*cos(initAzimuth).
SET azimuth to arctan(rotvelx / rotvely).
IF targetInclination < 0 {SET azimuth to 180-azimuth.}.

SET SHIP:CONTROL:MAINTHROTTLE TO 1.0.
LOCK STEERING TO HEADING(90, 90).
WAIT 1.
STAGE.
PRINT "Engines started.".
WAIT 4.
STAGE.
PRINT "Lift off".

WAIT UNTIL ALT:RADAR > 100.

PRINT "Gravity Turn".
SET fullySteeredAngle to 90 - waitPitch.
SET atmpGround TO SHIP:SENSORS:PRES.
//SET atmp_end to 0.

LOCK altitude to ALT:RADAR.
LOCK atmp to ship:sensors:pres.
LOCK atmoDensity to atmp / atmpGround.
LOCK apoeta to max(0,ETA:APOAPSIS).

LOCK firstPhasePitch to fullySteeredAngle - (fullySteeredAngle * atmoDensity).
LOCK STEERING to HEADING(azimuth, 90 - firstPhasePitch).
UNTIL apoeta >= targetApoeta {
	FLAMEOUT(3).
	ACTIVATORS().
	set endTurnAltitude to altitude.
	set endRurnOrbitSpeed to SHIP:VELOCITY:ORBIT:MAG.
	set secondPhasePitch to firstPhasePitch.
}
UNLOCK firstPhasePitch.
UNLOCK STEERING.
UNLOCK atmoDensity.
UNLOCK atmp.

SET atmoEndAltitude to 110000.
SET tolerance to targetApoeta * 0.5.
LOCK shipAngle to VANG(SHIP:UP:VECTOR, SHIP:SRFPROGRADE:VECTOR).
LOCK correctiondAmp to (altitude - endTurnAltitude) / (atmoEndAltitude - endTurnAltitude).
LOCK mx to shipAngle + (maxCorrection * correctiondAmp).
LOCK mi to shipAngle - (maxCorrection * correctiondAmp).
LOCK orbitSpeedFactor to ((targetOrbitSpeed - SHIP:VELOCITY:ORBIT:MAG) / (targetOrbitSpeed - endRurnOrbitSpeed)).
LOCK tApoEta to targetApoeta * orbitSpeedFactor. 
SET ae to 0.
LOCK correction to max(-maxCorrection*0.3,((tApoEta - ae) / tolerance) * maxCorrection).
LOCK secondPhasePitch to max(mi,min(mx, shipAngle - correction )).
LOCK STEERING to HEADING(azimuth, 90 - secondPhasePitch).

PRINT "Horizontal burn".
UNTIL ALT:PERIAPSIS >= 140000 {
	FLAMEOUT(3).
	ACTIVATORS().
	if SHIP:VERTICALSPEED > 0 {
		SET ae to apoeta.
	} else {
		SET ae to 0.
	}
}
//Performs engine shutdown.
for eng in enginesList{
    if eng:THRUST > 0{
        eng:SHUTDOWN.
    }
}
DELETEPATH("libLaunchUtils.ks").
SET SHIP:CONTROL:PILOTMAINTHROTTLE TO 0.
LOCK THROTTLE TO 0.
UNLOCK STEERING.