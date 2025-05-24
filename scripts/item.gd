extends PanelContainer

@onready var header_name_label: Label = $ItemTable/HeaderNameLabel
@onready var header_details_label: Label = $ItemTable/HeaderDetailsLabel
@onready var header_value_label: Label = $ItemTable/HeaderValueLabel
@onready var name_label: Label = $ItemTable/NameLabel
@onready var stats_label: Label = $ItemTable/StatsLabel
@onready var price_label: Label = $ItemTable/PriceLabel
@onready var auction_time_label: Label = $ItemTable/AuctionTimeLabel
@onready var buy_button: Button = $ItemTable/ButtonContainer/ButtonContent

var name_value: String
var quality_value: int 
var size_value: int
var expiration_value: int
var special_value: String
var price_value: float
