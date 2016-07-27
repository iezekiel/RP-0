// Launch LAN Window Script v1.0.0
// Constandinos Iezekiel 2016

PARAMETER targetLAN.

local difference is 1000.
until difference<2 and difference > 0{
    SET currentLAN TO SHIP:ORBIT:LAN + SHIP:ORBIT:ARGUMENTOFPERIAPSIS + SHIP:ORBIT:TRUEANOMALY.
    SET currentLAN TO currentLAN - 360*floor(currentLAN/360).
    SET difference TO targetLAN - currentLAN.
    Print "Difference:   "+ difference at (0,12).
    if difference>20{
        set warp to 4.
        }
    else if difference<20 and difference > 10{
        set warp to 3.
        }
    else if difference <10 and difference> 3{
        set warp to 2.
        }
    else if difference <3 and difference> 2.05{
        set warp to 1.
        }
    else if difference < 2.05 and difference> 0{
        set warp to 0.
        }
    else if difference < 0 {
        set warp to 4.
    }
    wait 0.001.
}
set warp to 0.
CLEARSCREEN.