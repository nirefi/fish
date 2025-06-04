extends PanelContainer

# define the const item scene
const AUCTION_ITEM = preload("res://scenes/item.tscn")
# define the nodes variables
@onready var item_spawn_timer: Timer = $ItemSpawnTimer
@onready var item_table: GridContainer = $MarginContainer/ItemListScrollContainer/GridContainer

func _ready() -> void:
	# randomise the seed
	randomize()

func _on_item_spawn_timer_timeout() -> void:
	var auction_item_instance = AUCTION_ITEM.instantiate()
	item_table.add_child(auction_item_instance)

# get first char from a string and returns the single char as a string
func get_first_char(full_word: String) -> String:
	return full_word.left(1)

func _on_ai_move_timer_timeout() -> void:
	if item_table.get_child_count() > 5:
		var auction_array: Array = item_table.get_children()
		var choosable_items: Array
		for i in range(auction_array.size()):
			if auction_array[i].item_time.time_left > 0:
				choosable_items.append(auction_array[i])
		var chosen_item = item_table.get_children().pick_random()
