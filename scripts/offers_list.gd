extends PanelContainer

const OFFER = preload("res://scenes/offer.tscn")
const COMPLETE_BUTTON = preload("res://scenes/complete_button.tscn")
@onready var offers_container: VBoxContainer = $MarginContainer/HBoxContainer/ScrollContainer/VBoxContainer
@onready var rich_text_label: RichTextLabel = $MarginContainer/HBoxContainer/VBoxContainerMessage/PanelContainer/MarginContainer/VBoxContainer/RichTextLabel
@onready var details_container: VBoxContainer = $MarginContainer/HBoxContainer/VBoxContainerMessage/PanelContainer/MarginContainer/VBoxContainer

func _on_offer_spawn_timer_timeout() -> void:
	if Global.unused_offers.is_empty():
		return
	var offer_instance = OFFER.instantiate()
	offer_instance.connect("offer_open", open_offer)
	offers_container.add_child(offer_instance)
	
func open_offer(offer_selected: OfferBase):
	print("test")
	rich_text_label.text = offer_selected.details
	var complete_button_instance = COMPLETE_BUTTON.instantiate()
	if offer_selected.has_requirements and not details_container.has_node("CompleteButton"):
		details_container.add_child(complete_button_instance)
	elif not offer_selected.has_requirements and details_container.has_node("CompleteButton"):
		details_container.remove_child(details_container.get_child(1))
