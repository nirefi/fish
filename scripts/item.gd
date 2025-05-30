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

# declare consts and variables
const ITEM_TOP_BID = preload("res://styles/item_top_bid.tres")
const BID_PRICE_MULTIPLIER: float = 1.3
var name_value: int
var quality_value: float 
var size_value: float
var expiration_value: float
var special_value: String
var price_value: float
var bids_array: Array
var current_bid_price: float

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
		
func _process(delta: float) -> void:
	# if the timer hasnt ended set the auction end time
	if item_time.time_left != 0:
		auction_time_label.text = "Closes: " + str(round(item_time.time_left)) + "s"

func _on_item_time_timeout() -> void:
	panel_disabled.visible = true
	auction_time_label.text = "Auction ended!"
	if bids_array.size() > 0:
		if bids_array[bids_array.size() -1] == Global.username:
			Global.items_held.append({"name" = name_value, "quality" = quality_value, "size" = size_value, "expiration" = expiration_value, "special" = special_value, "price" = price_value, "price_bought" = current_bid_price, "bid_history" = bids_array})
