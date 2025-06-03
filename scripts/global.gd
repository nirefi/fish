extends Node

var money: float = 1000.00
var day: int = 1
var player_exp: int = 0
var username: String = "Placeholder"
var items_held: Array
var all_offers: Array[OfferBase]
var current_offers: Array[OfferBase]
var unused_offers: Array[OfferBase]

func _ready() -> void:
	load_offers("res://resources/offers/")
	unused_offers = all_offers

# function to round, at some point will make sure its always the amount of places so it wont end up like 22.9 when at 2dp
func round_place(num, places):
	return (round(num * pow(10, places)) / pow(10, places))

func load_offers(path: String):
	var dir = DirAccess.open(path)
	if dir:
		for file in dir.get_files():
			var offer = load(path + "/" + file)
			if offer is OfferBase:
				all_offers.append(offer)
