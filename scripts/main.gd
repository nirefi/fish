extends Control

@onready var stats_label: Label = $VBoxContainer/PanelContainer/MarginContainer/StatsLabel

func _ready() -> void:
	update_stats()

func _on_browse_button_pressed() -> void:
	pass # Replace with function body.

func update_stats():
	stats_label.text = "Day: " + str(Global.day) + "| Balance: $" + str(Global.money) + " | Reputation:" + str(Global.rep)
	
# TODO LATER: UPDATE STATS BY A SIGNAL SENT WHEN ANY BID BUTTON IS PRESSED AS TO MAKE THIS MORE PERFORMANT
func _process(delta: float) -> void:
	update_stats()
