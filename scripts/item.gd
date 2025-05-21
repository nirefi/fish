extends PanelContainer

@onready var stats_label: Label = $ItemMargin/ItemDisplay/ItemInfoPanel/StatsLabel
@onready var price_label: Label = $ItemMargin/ItemDisplay/ItemInfoPanel/PriceLabel
@onready var buy_button: Button = $ItemMargin/ItemDisplay/ItemInfoPanel/BuyButton
@onready var item_icon: TextureRect = $ItemMargin/ItemDisplay/ItemIcon

signal order_pressed

var name_value: String
var quality_value: int 
var size_value: int
var expiration_value: int
var special_value: String
