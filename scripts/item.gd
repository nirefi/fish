extends PanelContainer

@onready var item_container: PanelContainer = $"."
@onready var icon_texture: TextureRect = $MarginContainer/VBoxContainer/IconTexture
@onready var details_button: Button = $MarginContainer/VBoxContainer/HBoxContainer/DetailsButton
@onready var auction_time_label: Label = $MarginContainer/VBoxContainer/HBoxContainer/AuctionTimeLabel
@onready var current_bid_value_label: Label = $MarginContainer/VBoxContainer/VBoxContainer/CurrentBidValueLabel
@onready var current_bid_label: Label = $MarginContainer/VBoxContainer/VBoxContainer/CurrentBidLabel
@onready var bid_button: Button = $MarginContainer/VBoxContainer/BidButtonContainer/BidButton
const ITEM_DISPLAY = preload("res://scenes/item_display.tscn")

var name_value: int
var quality_value: float 
var size_value: float
var expiration_value: float
var special_value: String
var price_value: float
var bids_array: Array
var current_bid_price: float

func _on_button_content_pressed(node):
	var item_display_instance = ITEM_DISPLAY.instantiate()
	node.add_child(item_display_instance)
