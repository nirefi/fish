extends Node

var money: float = 1000.00
var day: int = 1
var rep: int = 200
var username: String = "Placeholder"
var items_held: Array

# function to round, at some point will make sure its always the amount of places so it wont end up like 22.9 when at 2dp
func round_place(num, places):
	return (round(num * pow(10, places)) / pow(10, places))
