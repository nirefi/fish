extends PanelContainer

# define the const item scene
const AUCTION_ITEM = preload("res://scenes/item.tscn")
# define the nodes variables
@onready var item_spawn_timer: Timer = $ItemSpawnTimer
@onready var item_table: GridContainer = $MarginContainer/ItemListScrollContainer/GridContainer

# define the rng variable
var rng = RandomNumberGenerator.new()

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
	# randomise the seed
	randomize()
	
func create_button():
	# instantiate my item template and add it to the list
	var auction_item_instance = AUCTION_ITEM.instantiate()
	item_table.add_child(auction_item_instance)
	
	# set the names, qualities, expirations, size and price
	auction_item_instance.name_value = rng.randi_range(0, fish.size() - 1)
	auction_item_instance.quality_value = weighted_rand(20)
	auction_item_instance.expiration_value = rng.randi_range(1, 10)
	auction_item_instance.size_value = weighted_rand(4)
	# little thingy to give the fish a value
	auction_item_instance.price_value = (fish[auction_item_instance.name_value].base * 
	(auction_item_instance.quality_value / 20) * (auction_item_instance.expiration_value / 5) *
	(auction_item_instance.size_value / 5))
	
	# set the item icon by putting the name together jigsaw style
	auction_item_instance.icon_texture.texture = load("res://assets/sprites/" + (fish[auction_item_instance.name_value].name).to_lower() + "-icon.png")
	
	auction_item_instance.details_button.text = (fish[auction_item_instance.name_value].name + " " + str(auction_item_instance.quality_value) + "-" +
	str(auction_item_instance.size_value) + "KG-" + str(auction_item_instance.expiration_value) + "D-N")
	
	auction_item_instance.current_bid_value_label.text = "$%.02f" % auction_item_instance.price_value
	
	auction_item_instance.bid_text.text = "Place $" + str(Global.round_place(auction_item_instance.price_value * auction_item_instance.BID_PRICE_MULTIPLIER, 2)) + " bid »"

func _on_item_spawn_timer_timeout() -> void:
	create_button()

# get first char from a string and returns the single char as a string
func get_first_char(full_word: String) -> String:
	return full_word.left(1)

# fix: can be 0 (because x gets rolled as 1 and 1 - 1 is 0)
func weighted_rand(multiplier: int) -> int:
	var x: int = 5
	for i in range(5):
		if rng.randi_range(0, 1) == 0:
			x = i + 1
			break
	return rng.randi_range(x * multiplier, min((x + 1) * multiplier - 1, 100))
