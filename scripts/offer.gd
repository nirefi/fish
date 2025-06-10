extends PanelContainer

@onready var sender_label: Label = $MarginContainer/VBoxContainer/HBoxContainer/SenderLabel
@onready var details_label: Label = $MarginContainer/VBoxContainer/DetailsContainer/DetailsLabel
@onready var complete_container: PanelContainer = $MarginContainer/VBoxContainer/CompleteContainer

var offer_selected: OfferBase = Global.unused_offers.pick_random()
var fish_wanted: int = 0

signal offer_open

func _ready() -> void:
	offer_selected.duplicate()
	randomize()
	
	# FIX: CURRENTLY CODE IS MODIFYING ACTUAL RESOURCE WHEN IT DOES THIS, FIND A WAY FOR EVERY INSTANCE TO BE A CUSTOM DUPLICATION OF THE RESOURCE SO THEY CAN ALL HAVE DIFFERENT REQUIREMENTS ETC
	if offer_selected.has_requirements:
		if offer_selected.random_requirement:
			var fish_chosen: Dictionary = Global.fish.pick_random()
			offer_selected.requirement = fish_chosen["name"]

	sender_label.text = offer_selected.sender
	details_label.text = offer_selected.intro
	Global.current_offers.append(offer_selected)
	if offer_selected.repeatable == false:
		Global.unused_offers.erase(offer_selected)

func _on_button_pressed() -> void:
	emit_signal("offer_open", offer_selected)

func _on_trash_button_pressed() -> void:
	queue_free()

func _on_complete_button_pressed() -> void:
	for fish in Global.items_held:
		var players_fish_name = Global.fish[fish["name_id"]].name
		if players_fish_name == offer_selected.requirement:
			print("HAS")
			print(offer_selected.required_expiration, fish["expiration"], offer_selected.required_quality, fish["quality"], offer_selected.required_size, fish["size"])
			if offer_selected.required_expiration <= fish["expiration"] and offer_selected.required_quality <= fish["quality"] and offer_selected.required_size <= fish["size"]:
				Global.money += offer_selected.money_reward
				queue_free()
			break
