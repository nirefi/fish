extends PanelContainer

@onready var item_container: PanelContainer = $"."
@onready var name_label: Label = $ItemTable/NameLabel
@onready var stats_label: Label = $ItemTable/StatsLabel
@onready var price_label: Label = $ItemTable/PriceLabel
@onready var auction_time_label: Label = $ItemTable/AuctionTimeLabel
@onready var info_button: Button = $ItemTable/InfoButton
@onready var buy_button: PanelContainer = $ItemTable/ButtonContainer

var name_value: int
var quality_value: int 
var size_value: int
var expiration_value: int
var special_value: String
var price_value: float
