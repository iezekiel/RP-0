# A kOS scripts tutorial for RP-0.
This a repository for my personal playthought of Kerbal Space Program
RP-0 mod. Is a tutorial style presentation for the different kind of missions
and how i automated them with kOS mod. The main objective of this repository is
to assist new players, also the corporation of existing players to grow this library.

### So what is in your installation?
A standard RP-0 installation through CKAN. You can find CKAN [here](https://github.com/KSP-CKAN/CKAN).
```
ckan install RealismOverhaul
ckan install RP-0
ckan install SovietEnginePack
```
Also i am using kOS Prerelease for version 1.0.0. You can find it [here](https://github.com/KSP-KOS/KOS/releases).

### Why kOS Prerelease?
The changes in kOS v1.0.0 Release Candidate absolutely rock. Subdirectories, multiple boot files and 3rd party addon framework are some.

## How to use
The scripts are found in four directories.
* boot : The place for boot files.
* lib : The main library scripts that mission files use.
* missions : I generally create a mission file for each *type* of mission.
* ships : Here are specific scripts for each launch vehicle.

Except for Sounding Rockets each spacecraft uses two scripts. One for the mission which is the name of spacecraft. The other one is taken from the tag in the core part which is the name of the Launch Vehicle. The need for the ship script will be more clear later on.

## Library
libLaunchUtils.ks : Can detect staging when thrust is 0. Also drops fairings at 100000m and deploy antennas at 140000m.

libSounding.ks : The Sounding rockets logic. Stage until there is nothing else to stage.

libRealChute.ks : Used to arm parachutes.

libLaunchSolid.ks : Launches early rockets with solids as upper stages. After initial pitch the rocket follows prograde until apoapsis, then solids are firing to finish orbit. It can support one stage (example is Juno I) or two stages to apoapsis (like Vanguard or RP-0 tutorial ship). Ship must have RCS to guide the rocket to apopasis after last engine is flameout. Parameters accept Azimuth (not Inclination), and targetApoapsis for two stage rockets.

### Astra Missions (aka Sounding Rockets)
Select bootSR.ks as boot file, must rename vessel to the mission profile before launch. On a normal playthought I launch 5-6 sounding rockets before i am ready for Orbit. There are 3 kinds of Sounding Rockets mission profiles.
* Astra.mission.ks : A normal WAC Corporal sounding rocket. Just go up and stage when necessary. Example ships Astra 1, Astra 2, Astra 3.
* Astra P.mission.ks : Same as previously but arm parachutes at apoapsis. Example ships Astra 4.
* Astra B.mission.ks : The V2 sounding rocket profile where you can steer the rocket to gather biomes. Example ships Astra 5.

There is an another Astra.mission.ks profile found under missions/RP-0. For use on normal rockets that liftoff is done in two stages (one for engines start and one for clamps release).

### Gaia 1
Select boot.ks. The first orbitable rocket can be launch *normally* after having Early Rocketry and Early Avionics. My example ship is a Vanguard first stage with ABLE and solid stages. It utilizes libLaunchSolid.ks script. The ship file is not actually used but is required.
