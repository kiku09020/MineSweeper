#*--------------- Extend ---------------*
extends Node

#*--------------- Extported Fields ---------------*
@export var board: Board

#*--------------- Fields ---------------*

#*--------------- Methods ---------------*
## クリア可能なタイルを全てクリア
func clear_all_clearable_tiles():
	# タイルがまだクリアされていない場合は、一度クリアする
	if board.cleared_tile_count <= 0:
		board.tiles[0].cleared()

	for tile in board.tiles:
		if not tile.is_mine:
			tile.cleared()
			
	pass

func _on_input_manager_on_debug_input_f_1() -> void:
	print("Debug: Clear all clearable tiles.")
	clear_all_clearable_tiles()
