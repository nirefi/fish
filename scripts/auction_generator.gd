extends PanelContainer

const auction_item = preload("res://scenes/item.tscn")
@onready var item_list_container: VBoxContainer = $ItemListScrollContainer/VBoxContainer
@onready var item_spawn_timer: Timer = $ItemSpawnTimer
var rng = RandomNumberGenerator.new()

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
	randomize()
	print(get_first_char("test"))
	
func create_button():
	# instantiate my item template and add it to the list
	var auction_item_instance = auction_item.instantiate()
	item_list_container.add_child(auction_item_instance)
	auction_item_instance.quality_value = weighted_rand(20)
	auction_item_instance.expiration_value = rng.randi_range(1, 10)
	auction_item_instance.size_value = weighted_rand(4)

	auction_item_instance.stats_label.text = (str(auction_item_instance.quality_value) + "-" +
	str(auction_item_instance.size_value) + "KG-" + str(auction_item_instance.expiration_value) + "D-N")

func _on_item_spawn_timer_timeout() -> void:
	create_button()

# get first char from a string and returns the single char as a string
func get_first_char(full_word: String) -> String:
	return full_word.left(1)

# fix: can be 0 (because x gets rolled as 1 and 1 - 1 is 0)
func weighted_rand(multiplier: int):
	var x: int
	for i in range(5):
		if rng.randi_range(0, 1) == 0:
			x = i + 1
			break
		else:
			x = i +1
	return rng.randi_range((x - 1) * multiplier, (x) * multiplier)
