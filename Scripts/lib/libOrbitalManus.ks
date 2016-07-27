// Orbital Maneuvers Script v1.0.0
// Constandinos Iezekiel 2016
// Original Sources: https://github.com/TheBassist95/Kos-Stuff

function instantVelatAlt{
	parameter altitude.
	parameter sma.
	if sma=0 { set sma to ship:orbit:semimajoraxis.}
	local v is sqrt(Body:MU*((2/(altitude+body:radius))-(1/sma))).
	return v.
}

FUNCTION ChangeApoapsis{
	PARAMATER targetApopasis.

	LOCAL newsma to (periapsis+(body:radius*2)+targetApopasis)/2.
	LOCAL dv to instantVelatAlt(periapsis,newsma)-instantVelatAlt(periapsis,0).
	LOCAL myNode to node(time:seconds+eta:periapsis,0,0,dv).
	ADD myNode.
}
FUNCTION ChangePeriapsis{
	PARAMATER targetPeriapsis.

	LOCAL newsma to (targetPeriapsis+(body:radius*2)+apoapsis)/2.
	LOCAL dv to instantVelatAlt(apoapsis,newsma)-instantVelatAlt(apoapsis,0).
	LOCAL myNode to node(time:seconds+eta:apoapsis,0,0,dv).
	ADD myNode.
}

FUNCTION Hohmann {
	set newsma to (periapsis+(body:radius*2)+target:altitude)/2.
	set temperiod to 2*constant:pi*sqrt((newsma*newsma*newsma)/body:mu).
	set halfp to temperiod/2.
	set posv to positionat(target,time:seconds+halfp)-target:body:position.
	set temp to halfp/(360/target:orbit:period).
	set tempt to time:seconds.
	until tempt>time:seconds+ship:orbit:period{
		set shippos to positionat(ship,tempt)-ship:body:position.
		if ( vang(shippos,posv)>179)
			break.
		else
			set tempt to tempt+10.
	}
	set dv to instantVelatAlt((positionat(ship,tempt)-ship:body:position):mag-body:radius,newsma)-instantVelatAlt((positionat(ship,tempt)-ship:body:position):mag-body:radius,0).
	set myNode to node(tempt,0,0,dv).
	add mynode.
}