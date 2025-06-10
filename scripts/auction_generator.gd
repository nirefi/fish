extends PanelContainer

# define the const item scene
const AUCTION_ITEM = preload("res://scenes/item.tscn")
const ITEM_PLAYER_LOSING = preload("res://styles/item_player_losing.tres")
# define the nodes variables
@onready var item_spawn_timer: Timer = $ItemSpawnTimer
@onready var item_table: GridContainer = $MarginContainer/ItemListScrollContainer/GridContainer

func _on_item_spawn_timer_timeout() -> void:
	var auction_item_instance = AUCTION_ITEM.instantiate()
	item_table.add_child(auction_item_instance)

func _on_ai_move_timer_timeout() -> void:
	if item_table.get_child_count() > 1:
		var auction_array: Array = item_table.get_children()
		print(auction_array)
		var choosable_items: Array
		for i in range(auction_array.size()):
			if auction_array[i].item_time.time_left > 0 and auction_array[i].bids_array[auction_array[i].bids_array.size()]:
				choosable_items.append(auction_array[i])
		var chosen_item = choosable_items.pick_random()
		chosen_item.bids_array.append("AI1")
		chosen_item.item_container.add_theme_stylebox_override("panel", ITEM_PLAYER_LOSING)
