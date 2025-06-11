extends Control

@onready var main_content_panel: Panel = $VBoxContainer/MainContentPanel
@onready var navbar: PanelContainer = $VBoxContainer/PanelContainer

const ITEM_LIST = preload("res://scenes/item_list.tscn")
const OFFERS_LIST = preload("res://scenes/offers_list.tscn")
@onready var balance_label: Label = $VBoxContainer/PanelContainer/MarginContainer/HBoxContainer/StatsContainer/BalanceLabel
@onready var exp_label: Label = $VBoxContainer/PanelContainer/MarginContainer/HBoxContainer/StatsContainer/ExpLabel
@onready var day_label: Label = $VBoxContainer/PanelContainer/MarginContainer/HBoxContainer/StatsContainer/DayLabel
@onready var sanity_progress: ProgressBar = $VBoxContainer/PanelContainer/MarginContainer/HBoxContainer/StatsContainer/SanityLabel/SanityContainer/SanityProgress
@onready var sanity_timer: Timer = $SanityTimer
@onready var go_label: Label = $GOLabel

signal update_offers

func _ready() -> void:
	update_stats()

func _on_browse_button_pressed() -> void:
	hide_scenes_children(main_content_panel)
	if main_content_panel.has_node("ItemList"):
		main_content_panel.get_node("ItemList").visible = true
	else:
		if sanity_timer.is_stopped():
			sanity_timer.start()
		var item_list_instance = ITEM_LIST.instantiate()
		main_content_panel.add_child(item_list_instance)

func _on_offers_button_pressed() -> void:
	hide_scenes_children(main_content_panel)
	if main_content_panel.has_node("OffersContainer"):
		main_content_panel.get_node("OffersContainer").visible = true
	else:
		if sanity_timer.is_stopped():
			sanity_timer.start()
		var offers_list_instance = OFFERS_LIST.instantiate()
		main_content_panel.add_child(offers_list_instance)
	emit_signal("update_offers")

func _on_storage_button_pressed() -> void:
	# print the array of dictonary entries which is the storage. will not be adding proper display until finished minimum viable product
	print(Global.items_held)

func update_stats():
	# set the stats
	day_label.text = "Day: " + str(Global.day)
	balance_label.text = "Balance: " + str(Global.round_place(Global.money, 2))
	exp_label.text = "Experience: " + str(Global.player_exp)
	if sanity_timer.is_stopped():
		return
	sanity_progress.value = (sanity_timer.time_left / Global.sanity) * 100
	
# TODO LATER: UPDATE STATS BY A SIGNAL SENT WHEN ANY BID BUTTON IS PRESSED AS TO MAKE THIS MORE PERFORMANT
func _process(_delta: float) -> void:
	update_stats()
	
func hide_scenes_children(scene: Node) -> void:
	for child in scene.get_children():
		child.visible = false

func _on_sanity_timer_timeout() -> void:
	hide_scenes_children(main_content_panel)
	hide_scenes_children(navbar)
	go_label.text = "Game over!\n You you had: $"  + str(Global.round_place(Global.money, 2))
	go_label.visible = true
