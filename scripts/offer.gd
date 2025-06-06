extends PanelContainer

@onready var sender_label: Label = $MarginContainer/VBoxContainer/HBoxContainer/SenderLabel
@onready var details_label: Label = $MarginContainer/VBoxContainer/DetailsContainer/DetailsLabel
@onready var complete_container: PanelContainer = $MarginContainer/VBoxContainer/CompleteContainer

var offer_selected: OfferBase = Global.unused_offers.pick_random()

signal offer_open

func _ready() -> void:
	randomize()
	
	sender_label.text = offer_selected.sender
	details_label.text = offer_selected.intro
	if not offer_selected.has_requirements :
		complete_container.visible = false
	Global.current_offers.append(offer_selected)
	Global.unused_offers.erase(offer_selected)

func _on_button_pressed() -> void:
	emit_signal("offer_open", offer_selected)

func _on_trash_button_pressed() -> void:
	self.queue_free()

func _on_complete_button_pressed() -> void:
	print("test")
