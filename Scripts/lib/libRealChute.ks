// Real Chutes Script v1.0.0
// Constandinos Iezekiel 2016

PARAMETER event.

FOR RealChute IN SHIP:modulesNamed("RealChuteModule") {
    PRINT "Real Chute: " + event.
    RealChute:doevent(event).
    BREAK.
}.