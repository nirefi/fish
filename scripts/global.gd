extends Node

var money: float = 1000.00
var day: int = 1
var rep: int = 200
var username: String = "Placeholder"
var items_held: Array

func round_place(num, places):
	return (round(num * pow(10, places)) / pow(10, places))
