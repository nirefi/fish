extends PanelContainer

@onready var stats_label: Label = $ItemMargin/ItemDisplay/ItemInfoPanel/StatsLabel
@onready var price_label: Label = $ItemMargin/ItemDisplay/ItemInfoPanel/HBoxContainer/PriceLabel
@onready var buy_button: Button = $ItemMargin/ItemDisplay/ItemInfoPanel/BuyButton
@onready var item_icon: TextureRect = $ItemMargin/ItemDisplay/ItemIcon
@onready var auction_time_label: Label = $ItemMargin/ItemDisplay/ItemInfoPanel/HBoxContainer/AuctionTimeLabel

var name_value: String
var quality_value: int 
var size_value: int
var expiration_value: int
var special_value: String
var price_value: float
