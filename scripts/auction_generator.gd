extends PanelContainer

# define the const item scene
const AUCTION_ITEM = preload("res://scenes/item.tscn")
const ITEM_PLAYER_LOSING = preload("res://styles/item_player_losing.tres")
# define the nodes variables
@onready var item_spawn_timer: Timer = $ItemSpawnTimer
@onready var item_table: GridContainer = $MarginContainer/ItemListScrollContainer/GridContainer
@onready var ai_move_timer: Timer = $AIMoveTimer

func _on_item_spawn_timer_timeout() -> void:
	var auction_item_instance = AUCTION_ITEM.instantiate()
	item_table.add_child(auction_item_instance)

func _on_ai_move_timer_timeout() -> void:
	if item_table.get_child_count() > 1:
		var auction_array: Array = item_table.get_children()
		var choosable_items: Array
		for i in range(auction_array.size() - 1):
			# ONLY CHECK FINAL ITEM OF BIDS!!
			if auction_array[i].item_time.time_left > 0.0:
				if auction_array[i].bids_array.is_empty() or auction_array[i].bids_array[auction_array[i].bids_array.size() - 1] != "AI1":
					choosable_items.append(auction_array[i])

		choose_ai_item(choosable_items, "AI1")
		ai_move_timer.start(RandomNumberGenerator.new().randi_range(2, 4))
		
func choose_ai_item(choosable_items: Array, ai_name: String):
	var chosen_item = choosable_items.pick_random()
	chosen_item.bids_array.append(ai_name)
	chosen_item.item_container.add_theme_stylebox_override("panel", ITEM_PLAYER_LOSING)
	if chosen_item.bids_array.size() > 0:
		chosen_item.current_bid_price *= chosen_item.BID_PRICE_MULTIPLIER
	else:
		# current bid price will be 0 so should be the price value multiplied by it
		chosen_item.current_bid_price = chosen_item.price_value * chosen_item.BID_PRICE_MULTIPLIER
		# set the timer to be the current time + 5 seconds
		chosen_item.item_time.start(chosen_item.item_time.time_left + 5)
		chosen_item.bid_text.text = "Place $" + str(Global.round_place(chosen_item.current_bid_price * chosen_item.BID_PRICE_MULTIPLIER, 2)) + " bid »"
		chosen_item.current_bid_value_label.text = "$" + str(Global.round_place(chosen_item.current_bid_price, 2))
