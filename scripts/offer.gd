extends PanelContainer

@onready var sender_label: Label = $MarginContainer/VBoxContainer/HBoxContainer/SenderLabel
@onready var details_label: Label = $MarginContainer/VBoxContainer/DetailsContainer/DetailsLabel
@onready var complete_container: PanelContainer = $MarginContainer/VBoxContainer/CompleteContainer
@onready var texture_rect: TextureRect = $MarginContainer/VBoxContainer/CompleteContainer/TextureRect
const RED_GRADIENT = preload("res://styles/red_gradient.tres")
const DIM_RED_GRADIENT = preload("res://styles/dim_red_gradient.tres")

var offer_selected: OfferBase = Global.unused_offers.pick_random()
var fish_wanted: int = 0

signal offer_open

func _ready() -> void:
	randomize()
	
	if Global.items_held.has(offer_selected.requirement):
		texture_rect.texture = RED_GRADIENT
	else:
		texture_rect.texture = DIM_RED_GRADIENT
	
	if offer_selected.has_requirements:
		if offer_selected.random_requirement:
			offer_selected = offer_selected.duplicate()
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
				Global.items_held.erase(fish)
				# not 100% sure if this works
				Global.current_offer_instances.erase(self)
				queue_free()
			break
