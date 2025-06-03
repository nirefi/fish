extends PanelContainer

const OFFER = preload("res://scenes/offer.tscn")
@onready var offers_container: VBoxContainer = $MarginContainer/HBoxContainer/ScrollContainer/VBoxContainer

func _on_offer_spawn_timer_timeout() -> void:
	if Global.unused_offers.is_empty():
		return
	var offer_instance = OFFER.instantiate()
	offers_container.add_child(offer_instance)
