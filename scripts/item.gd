extends PanelContainer

@onready var item_container: PanelContainer = $"."
@onready var icon_texture: TextureRect = $MarginContainer/VBoxContainer/IconTexture
@onready var details_button: Button = $MarginContainer/VBoxContainer/HBoxContainer/DetailsButton
@onready var auction_time_label: Label = $MarginContainer/VBoxContainer/HBoxContainer/AuctionTimeLabel
@onready var current_bid_value_label: Label = $MarginContainer/VBoxContainer/VBoxContainer/CurrentBidValueLabel
@onready var current_bid_label: Label = $MarginContainer/VBoxContainer/VBoxContainer/CurrentBidLabel
@onready var bid_button: Button = $MarginContainer/VBoxContainer/BidButtonContainer/BidButton
@onready var item_time: Timer = $ItemTime
const ITEM_TOP_BID = preload("res://styles/item_top_bid.tres")

var name_value: int
var quality_value: float 
var size_value: float
var expiration_value: float
var special_value: String
var price_value: float
var bids_array: Array
var current_bid_price: float

signal bid_pressed

func _on_bid_button_pressed() -> void:
	if Global.money > price_value:
		Global.money -= price_value
		bid_pressed.emit()
		item_container.add_theme_stylebox_override("panel", ITEM_TOP_BID)
		
func _process(delta: float) -> void:
	auction_time_label.text = str(item_time.time_left)
