extends PanelContainer

@onready var sender_label: Label = $MarginContainer/VBoxContainer/HBoxContainer/SenderLabel
@onready var details_label: Label = $MarginContainer/VBoxContainer/DetailsLabel

func _ready() -> void:
	randomize()
	
	var offer_selected: OfferBase = Global.unused_offers.pick_random()
	sender_label.text = offer_selected.sender
	details_label.text = offer_selected.intro
	Global.current_offers.append(offer_selected)
	Global.unused_offers.erase(offer_selected)
	
