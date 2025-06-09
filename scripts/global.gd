extends Node

var money: float = 1000.00
var day: int = 1
var player_exp: int = 0
var username: String = "Placeholder"
var items_held: Array
var all_offers: Array[OfferBase]
var current_offers: Array[OfferBase]
var unused_offers: Array[OfferBase]
var sanity: int = 120

# defining the fish array of dictionaries
var fish: Array = [
	{"name": "Salmon", "base": 70, "fact": "Salmon can actually jump up to two metres, only 0.4m away from the Olympic world record!"},
	{"name": "Tuna", "base": 80, "fact": "The bluefin tuna is the largest tuna species. It can grow up to 4m long and weight up to 800kgs!"},
	{"name": "Cod", "base": 40, "fact": "Cods can travel up to 320km to reach their breeding grounds during mating season!"},
	{"name": "Trout", "base": 50, "fact": "Trouts can rapidly change colour depending on their surroundings or their mood."},
	{"name": "Snapper", "base": 60, "fact": "Snappers have their name because of the audible snap their powerful jaws make when biting down!"},
	{"name": "Catfish", "base": 20, "fact": "Catfish don't just swim, they can walk on land, climb walls and even breath air."},
	{"name": "Carp", "base": 10, "fact": "Wild carp can live up to 40 years in the wild and the oldest carp was 226 years old."},
	{"name": "Herring", "base": 10, "fact": "Herrings swim in schools that can consist of millions of fish and be as high as 100 metres."},
	{"name": "Pike", "base": 30, "fact": "A single female pike could produce between 50,000 and 500,000 eggs in her lifetime."}
]

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
