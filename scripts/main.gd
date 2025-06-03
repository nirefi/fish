extends Control

@onready var stats_label: Label = $VBoxContainer/PanelContainer/MarginContainer/StatsLabel
@onready var main_content_panel: Panel = $VBoxContainer/MainContentPanel
const ITEM_LIST = preload("res://scenes/item_list.tscn")
const OFFERS_LIST = preload("res://scenes/offers_list.tscn")

func _ready() -> void:
	update_stats()

func _on_browse_button_pressed() -> void:
	hide_scenes_children(main_content_panel)
	if main_content_panel.has_node("ItemList"):
		print("TEST")
	else:
		var item_list_instance = ITEM_LIST.instantiate()
		main_content_panel.add_child(item_list_instance)

func _on_offers_button_pressed() -> void:
	pass # Replace with function body.

func _on_storage_button_pressed() -> void:
	# print the array of dictonary entries which is the storage. will not be adding proper display until finished minimum viable product
	print(Global.items_held)

func update_stats():
	# set the stats
	stats_label.text = "Day: " + str(Global.day) + "| Balance: $" + str(Global.round_place(Global.money, 2)) + " | Reputation: " + str(Global.rep)
	
# TODO LATER: UPDATE STATS BY A SIGNAL SENT WHEN ANY BID BUTTON IS PRESSED AS TO MAKE THIS MORE PERFORMANT
func _process(delta: float) -> void:
	update_stats()
	
func hide_scenes_children(scene: Node) -> void:
	for child in scene.get_children():
		child.visible = false
