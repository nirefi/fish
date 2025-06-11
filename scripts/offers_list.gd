extends PanelContainer

const OFFER = preload("res://scenes/offer.tscn")
const DIM_RED_GRADIENT = preload("res://styles/dim_red_gradient.tres")
@onready var offers_container: VBoxContainer = $MarginContainer/HBoxContainer/ScrollContainer/VBoxContainer
@onready var rich_text_label: RichTextLabel = $MarginContainer/HBoxContainer/VBoxContainerMessage/PanelContainer/MarginContainer/VBoxContainer/RichTextLabel
@onready var details_container: VBoxContainer = $MarginContainer/HBoxContainer/VBoxContainerMessage/PanelContainer/MarginContainer/VBoxContainer

@export var default_offer: OfferBase

func _on_offer_spawn_timer_timeout() -> void:
	if Global.unused_offers.is_empty():
		return
	var offer_instance = OFFER.instantiate()
	offer_instance.connect("offer_open", open_offer)
	offers_container.add_child(offer_instance)
	
func open_offer(offer_selected: OfferBase):
	rich_text_label.text = (offer_selected.details
	.replace("MONEY_REWARD", str(offer_selected.money_reward))
	.replace("FISH_NAME", offer_selected.requirement.to_lower())
	.replace("REQUIRED_QUALITY", str(offer_selected.required_quality))
	.replace("REQUIRED_SIZE", str(offer_selected.required_size))
	)
