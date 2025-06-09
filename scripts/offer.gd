extends PanelContainer

@onready var sender_label: Label = $MarginContainer/VBoxContainer/HBoxContainer/SenderLabel
@onready var details_label: Label = $MarginContainer/VBoxContainer/DetailsContainer/DetailsLabel
@onready var complete_container: PanelContainer = $MarginContainer/VBoxContainer/CompleteContainer

var offer_selected: OfferBase = Global.unused_offers.pick_random()
var fish_wanted: int = 0

signal offer_open

func _ready() -> void:
	randomize()
	
	if offer_selected.has_requirements:
		if offer_selected.requirement:
			print(offer_selected.requirement)
		else:
			var fish_chosen = Global.fish.pick_random()
			offer_selected.requirement = fish_chosen["name"]
			print(offer_selected.requirement)

	sender_label.text = offer_selected.sender
	details_label.text = offer_selected.intro
	Global.current_offers.append(offer_selected)
	if offer_selected.repeatable == false:
		Global.unused_offers.erase(offer_selected)

func _on_button_pressed() -> void:
	emit_signal("offer_open", offer_selected)

func _on_trash_button_pressed() -> void:
	self.queue_free()

func _on_complete_button_pressed() -> void:
	for fish in Global.items_held:
		print(Global.items_held)
		if fish["name_value"] == offer_selected.requirement:
			print("HAS")
			break
