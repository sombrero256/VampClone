class_name PlayerUnlocks extends Node

##This is a player stat tracker for all stats we want to track across scenes
##Please do not try to reset or destroy this, or it will crash the game!

##Player HP
var PlayerMaxHealth = 100
var PlayerCurrentHealth = 100
##Counts for all the animals collected
var PlayerAnimal1Count = 0
var PlayerAnimal2Count = 0
var PlayerAnimal3Count = 0
##If we need separate XP for the player
var PlayerExp = 0
##If we need to keep track of player overall level
var PlayerLevel = 1
##Weapons unlocked/locked
var PlayerHasBoomerang = false
var PlayerHasBeam = false
var PlayerHasSplash = false
##Weapon level
var PlayerBoomerangLevel = 0
var PlayerHeartLevel = 0
var PlayerBeamLevel = 0
var PlayerSplashLevel = 0
##Money if we need it
var PlayerCash = 0
##Speed level if we need it
var PlayerSpeed = 3
