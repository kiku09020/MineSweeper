#*--------------- Extend ---------------*
extends Panel

#*--------------- Extported Fields ---------------*
@export_group("Nodes")
@export var tile_packed_scene: PackedScene
@export var container: GridContainer

@export_group("Properties")
@export var board_size = 4

#*--------------- Fields ---------------*
var tiles: Array = []

var is_generated_tiles = false

#*--------------- Signals ---------------*

#*--------------- Events ---------------*
func _ready() -> void:
	setup_container()

	generate_tiles()
	pass

func _process(_delta: float) -> void:
	pass

# Input
func _input(_event: InputEvent) -> void:
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
		tile.on_button_clicked.connect(func(): set_mines_on_tiles())

#------------------------------------------------------------

## 爆弾をセット
func set_mines_on_tiles():
	if is_generated_tiles: return

	for tile in tiles:
		# 爆弾セット
		tile.set_mine()

	for tile in tiles:
		# タイルの周りの爆弾数をカウント
		set_mines_around_count(tile)

	is_generated_tiles = true
	pass

## タイルの周りの爆弾数をカウント
func set_mines_around_count(tile: Tile):
	var _position = tile.tile_position
	var count = 0

	for i in range( - 1, 2):
		for j in range( - 1, 2):
			var target_position = _position + Vector2i(i, j)
			# 範囲外の場合はスキップ
			if target_position.x < 0 or target_position.x >= board_size: continue
			if target_position.y < 0 or target_position.y >= board_size: continue
			if target_position == _position: continue # 自分自身はスキップ

			# 目標タイルが爆弾の場合、カウント
			var target_tile = tiles[target_position.y * board_size + target_position.x]
			if target_tile.is_mine:
				count += 1
	
	tile.set_mine_count(count)

#------------------------------------------------------------
