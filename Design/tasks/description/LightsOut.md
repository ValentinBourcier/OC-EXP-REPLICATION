# Lights Out game 

## The application

LightsOutGame is a small graphical application that can be launched via `LightsOutGame class >> #open` (click on it).

* Run the application by executing this method (clic on the play button near the method name).

You should see the following application:

![Lights out game](https://raw.githubusercontent.com/Pharo-XP-Tools/xp-free-resources/main/ocd/lights-out-game.png)

In this game, each tile represents a light bulb initially switched off. 
Clicking on a tile will toggle it and its immediate neighbors, as illustrated below.

![Lights out game, toggled tiles](https://raw.githubusercontent.com/Pharo-XP-Tools/xp-free-resources/main/ocd/lights-out-game-toggles.png)

To win the game, a player must switch on all the lights in a minimal amount of actions.

## The problem

Unfortunately, there is a bug. As shown in the screenshot below, one light bulb located at one of the corners cannot be switched on. 

![Lights out game, bug](https://raw.githubusercontent.com/Pharo-XP-Tools/xp-free-resources/main/ocd/lights-out-game-bug.png)

Each time the game is launched, the bug appears in a new corner.

## Your task

* Understand why there is a light that cannot be switched on.
* Fix the bug. Identify and delete the method responsible for this behavior.

To help you, you can inspect any tile/light by performing a right-click on it. This action will open an inspector on that tile/light.

**Beware:** this is a graphical application, and putting breakpoints in the display system (e.g., in the Morph class) might freeze your system.
