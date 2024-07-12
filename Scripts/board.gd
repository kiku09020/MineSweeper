#*--------------- Extend ---------------*
extends Panel

#*--------------- Extported Fields ---------------*
@export_group("Nodes")
@export var tile_packed_scene: PackedScene
@export var container: GridContainer

@export_group("Properties")
@export var board_size = 4
@export var generated_mine_count = 10

#*--------------- Fields ---------------*
var tiles: Array = []

var is_generated_tiles = false

var current_flag_count = 0

#*--------------- Signals ---------------*
signal on_rest_mine_count_changed(flag_count: int)

#*--------------- Events ---------------*
func _ready() -> void:
	# コンテナ初期化
	setup_container()

	# タイル生成
	generate_tiles()

	# 爆弾数をセット
	set_rest_mine_count()
	pass

#*--------------- Methos ---------------*
## コンテナ初期化
func setup_container():
	# サイズ設定
	container.columns = board_size
	pass

## タイル生成
func generate_tiles():
	var current_tile_position = Vector2i.ZERO

	for i in range(board_size * board_size):
		current_tile_position = Vector2i(i % board_size, i / board_size)

		var tile = tile_packed_scene.instantiate()
		container.add_child(tile)
		tile.generated(current_tile_position)
		tiles.append(tile)
		
		# はじめにクリックされたタイミングで、爆弾をセット
		tile.on_button_clicked.connect(func():
			set_mines_on_tiles()
			clear_tiles_around_zero(tile)
		)

		# フラグイベントにフラグカウント追加処理を追加
		tile.on_flag_changed.connect(func(is_flag: bool):
			if is_flag:
				current_flag_count += 1
			else:
				current_flag_count -= 1

			set_rest_mine_count()
		)

#------------------------------------------------------------

## 爆弾をセット
func set_mines_on_tiles():
	if is_generated_tiles: return

	var mine_count = 0
	var mines = []

	# 爆弾をセット
	while mine_count < generated_mine_count:
		var random_index = randi() % (board_size * board_size)
		if mines.find(random_index) != - 1: continue # すでに爆弾がセットされている場合は再抽選
		mines.push_back(random_index)
		tiles[random_index].set_mine()

		mine_count += 1

	for tile in tiles:
		# タイルの周りの爆弾数をカウント
		set_mines_around_count(tile)

	is_generated_tiles = true
	pass

## タイルの周りの爆弾数をカウント
func set_mines_around_count(tile: Tile):
	var _position = tile.tile_position
	var count = 0

	for target_tile in get_around_tiles(tile, true):
		if target_tile.is_mine:
			count += 1
	
	tile.set_mine_count(count)

## 残りの爆弾数をセット
func set_rest_mine_count():
	var rest_mine_count = generated_mine_count - current_flag_count
	on_rest_mine_count_changed.emit(rest_mine_count)

#------------------------------------------------------------

## 0タイルをクリックしたときに、周りの数字タイルのクリア処理
func clear_tiles_around_zero(tile: Tile):
	# 0タイル以外はスキップ
	if tile.count != 0 or tile.is_flag: return

	# クリックされたタイルをキューに追加
	var queue: Array = []
	queue.append(tile)

	# キューが空になるまで繰り返す
	while !queue.is_empty():
		var current_tile = queue.pop_front()

		# タイルクリア
		current_tile.cleared()

		# タイルの斜めを除く周りの爆弾タイル以外をクリア
		var target_tiles = get_around_tiles(current_tile, true)
		for target_tile in target_tiles:
			if target_tile.is_mine or target_tile.is_cleared or current_tile.count != 0: continue

			# タイルをキューに追加
			queue.append(target_tile)

#------------------------------------------------------------
## タイルの周りのタイルを取得
func get_around_tiles(tile: Tile, contains_diagonal: bool):
	var _position = tile.tile_position
	var around_tiles: Array = []

	for i in range( - 1, 2):
		for j in range( - 1, 2):
			var target_position = _position + Vector2i(i, j)
			# 範囲外の場合はスキップ
			if target_position.x < 0 or target_position.x >= board_size: continue
			if target_position.y < 0 or target_position.y >= board_size: continue
			if target_position == _position: continue # 自分自身はスキップ

			# 斜めスキップ
			if !contains_diagonal and i != 0 and j != 0: continue

			around_tiles.append(tiles[target_position.y * board_size + target_position.x])

	return around_tiles
