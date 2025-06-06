extends PanelContainer

# declare variables for nodes
@onready var item_container: PanelContainer = $"."
@onready var icon_texture: TextureRect = $MarginContainer/VBoxContainer/IconTexture
@onready var details_button: Button = $MarginContainer/VBoxContainer/HBoxContainer/DetailsButton
@onready var auction_time_label: Label = $MarginContainer/VBoxContainer/HBoxContainer/AuctionTimeLabel
@onready var current_bid_value_label: Label = $MarginContainer/VBoxContainer/VBoxContainer/CurrentBidValueLabel
@onready var current_bid_label: Label = $MarginContainer/VBoxContainer/VBoxContainer/CurrentBidLabel
@onready var bid_button: Button = $MarginContainer/VBoxContainer/BidButtonContainer/BidButton
@onready var item_time: Timer = $ItemTime
@onready var bid_text: Label = $MarginContainer/VBoxContainer/BidButtonContainer/BidText
@onready var panel_disabled: PanelContainer = $PanelDisabled
@onready var animation_player: AnimationPlayer = $AnimationPlayer

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

# declare consts and variables
const ITEM_TOP_BID = preload("res://styles/item_top_bid.tres")
const BID_PRICE_MULTIPLIER: float = 1.3
var name_value: int
var quality_value: float 
var size_value: float
var expiration_value: float
var alive_value: String
var price_value: float
var bids_array: Array
var current_bid_price: float

func _ready() -> void:
	randomize()
		
	# set the names, qualities, expirations, size and price
	name_value = rng.randi_range(0, fish.size() - 1)
	quality_value = weighted_rand(20)
	expiration_value = rng.randi_range(1, 10)
	size_value = weighted_rand(4)
	# little thingy to give the fish a value
	price_value = (fish[name_value].base * 
	(quality_value / 20) * (expiration_value / 5) *
	(size_value / 5))
	
	# set the item icon by putting the name together jigsaw style
	icon_texture.texture = load("res://assets/sprites/" + (fish[name_value].name).to_lower() + "-icon.png")
	
	details_button.text = (fish[name_value].name + " " + str(quality_value) + "-" +
	str(size_value) + "KG-" + str(expiration_value) + "D-N")
	
	current_bid_value_label.text = "$%.02f" % price_value
	
	bid_text.text = "Place $" + str(Global.round_place(price_value * BID_PRICE_MULTIPLIER, 2)) + " bid »"

func _on_bid_button_pressed() -> void:
	# if the bids array isnt empty then current_bid_price shouldnt be 0 so its fine to do this
	if bids_array.size() > 0:
		current_bid_price *= BID_PRICE_MULTIPLIER
	else:
		# current bid price will be 0 so should be the price value multiplied by it
		current_bid_price = price_value * BID_PRICE_MULTIPLIER
	# if your money is bigger than or equal to the price of the item
	if Global.money >= current_bid_price:
		# set the timer to be the current time + 5 seconds
		item_time.start(item_time.time_left + 5)
		Global.money -= current_bid_price
		item_container.add_theme_stylebox_override("panel", ITEM_TOP_BID)
		bid_text.text = "Place $" + str(Global.round_place(current_bid_price * BID_PRICE_MULTIPLIER, 2)) + " bid »"
		current_bid_value_label.text = "$" + str(Global.round_place(current_bid_price, 2))
		bids_array.append(Global.username)
		
func _process(_delta: float) -> void:
	# if the timer hasnt ended set the auction end time
	if item_time.time_left != 0:
		auction_time_label.text = "Closes: " + str(round(item_time.time_left)) + "s"

func _on_item_time_timeout() -> void:
	animation_player.play("auction_closed")
	auction_time_label.text = "Auction ended!"
	if bids_array.size() > 0:
		if bids_array[bids_array.size() -1] == Global.username:
			Global.items_held.append({"name" = name_value, "quality" = quality_value, "size" = size_value, "expiration" = expiration_value, "alive" = alive_value, "price" = price_value, "price_bought" = current_bid_price, "bid_history" = bids_array})
			Global.player_exp += 10

func weighted_rand(multiplier: int) -> int:
	var x: int = 5
	for i in range(5):
		if rng.randi_range(0, 1) == 0:
			x = i + 1
			break
	return rng.randi_range(x * multiplier, min((x + 1) * multiplier - 1, 100))
