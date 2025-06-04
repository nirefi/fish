extends PanelContainer

@onready var sender_label: Label = $MarginContainer/VBoxContainer/HBoxContainer/SenderLabel
@onready var details_label: Label = $MarginContainer/VBoxContainer/DetailsContainer/DetailsLabel
var offer_selected: OfferBase = Global.unused_offers.pick_random()

signal offer_open

func _ready() -> void:
	randomize()
	
	sender_label.text = offer_selected.sender
	details_label.text = offer_selected.intro
	Global.current_offers.append(offer_selected)
	Global.unused_offers.erase(offer_selected)

func _on_button_pressed() -> void:
	emit_signal("offer_open", offer_selected)
