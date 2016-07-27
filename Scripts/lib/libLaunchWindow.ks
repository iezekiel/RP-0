// Launch Window Script v1.0.0
// Constandinos Iezekiel 2016
// Source: https://github.com/TheBassist95/Kos-Stuff

FUNCTION NORMALVECTOR {
	parameter orbitable.

	SET vel to VELOCITYAT(orbitable,TIME:seconds):ORBIT.
	SET norm to VCRS(vel,orbitable:UP:VECTOR).
	RETURN norm:normalized.
}

LOCAL c IS 0.
FUNCTION TRICALC {
	local a is latitude.
	local alpha is TARGET:ORBIT:INCLINATION.
	local b is 0.
	local bell is 90.
	local gamma is 0.
	if sin(a)*sin(bell)/sin(alpha) >1 {
		SET b to 90.
	}
	else{
		SET b to arcsin(sin(a)*sin(bell)/sin(alpha)).
	}
	SET c to 2*arctan(tan(.5*(a-b))*(sin(.5*(alpha+bell))/sin(.5*(alpha-bell)))).
	return c.
}

LOCAL alt1 IS FALSE.
CLEARSCREEN.
LOCK tLan to mod((360-TARGET:ORBIT:LAN) + BODY:ROTATIONANGLE,360).
IF longitude<0 {
	SET shiplon to abs(longitude).
}
ELSE {
	SET shiplon to 360-longitude.
}

IF TARGET:ORBIT:INCLINATION<ABS(latitude) { //If normal launch is impossible.
	SET tgtnormal to NORMALVECTOR(target).
	SET difference to vang(NORMALVECTOR(ship),tgtnormal).
	SET alt1 to true.
	SET min to ship:orbit:inclination-TARGET:ORBIT:inclination.
}
ELSE{	//If normal launch is possible.
	SET offset to TRICALC().
	SET min to 0.
}
LOCAL difference is 1000.
UNTIL difference<min+2{
	IF alt1{
		set difference to vang(NORMALVECTOR(ship),NORMALVECTOR(target)).
		Print "Relative Inclination:   "+ difference at (0,12).
		print "Minimum R. Inclination: "+ min at (0,13).
	}
	ELSE{
		set difference to abs((shiplon+c)-tlan).
		print "Relative LAN to Target: " + difference at (0,12).
	}
	IF difference>30{
		set warp to 4.
	}
	ELSE IF difference<50 and difference > min+3{
		set warp to 3.
	}
	ELSE IF difference <min+3 and difference> min+2.4{
		set warp to 2.
	}
	ELSE IF difference <min+2.3 and difference> min+2.2{
		set warp to 1.
	}
	ELSE IF difference <min+2.05 and difference> min{
		set warp to 0.
	}
	wait .001.
}
set warp to 0.
CLEARSCREEN.


