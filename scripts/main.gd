extends Control

@onready var stats_label: Label = $VBoxContainer/PanelContainer/MarginContainer/StatsLabel
var current_scene = ["browse", "offers", "storage"]

func _ready() -> void:
	update_stats()

func _on_browse_button_pressed() -> void:
	# set current scene to be browse
	current_scene[0]

func update_stats():
	# set the stats
	stats_label.text = "Day: " + str(Global.day) + "| Balance: $" + str(Global.round_place(Global.money, 2)) + " | Reputation: " + str(Global.rep)
	
# TODO LATER: UPDATE STATS BY A SIGNAL SENT WHEN ANY BID BUTTON IS PRESSED AS TO MAKE THIS MORE PERFORMANT
func _process(delta: float) -> void:
	update_stats()


func _on_storage_button_pressed() -> void:
	# print the array of dictonary entries which is the storage. will not be adding proper display until finished minimum viable product
	print(Global.items_held)


func _on_offers_button_pressed() -> void:
	pass # Replace with function body.
