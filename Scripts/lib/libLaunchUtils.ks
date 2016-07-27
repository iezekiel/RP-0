GLOBAL prevMaxThrust TO 0.

FUNCTION FLAMEOUT {
  PARAMETER waitTime IS 1.

  IF MAXTHRUST < (prevMaxThrust - 40) {
    STAGE.
    PRINT "Autostage".
    WAIT waitTime.
  }
  SET prevMaxThrust TO MAXTHRUST.
}

FUNCTION ACTIVATORS {
  IF SHIP:ALTITUDE > 100000 {
    FOR module IN SHIP:MODULESNAMED("ProceduralFairingDecoupler") {
      module:DOEVENT("jettison").
      PRINT "Jettisoning Fairings".
    }.
  }.
  IF SHIP:ALTITUDE > 140000 {
    FOR antenna IN SHIP:MODULESNAMED("ModuleRTAntenna") {
      IF antenna:HASEVENT("activate") {
        antenna:DOEVENT("activate").
        PRINT "Activate Antennas".
      }.
    }.
  }.
}
