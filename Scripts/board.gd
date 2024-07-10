#*--------------- Extend ---------------*
extends Panel

#*--------------- Extported Fields ---------------*
@export_group("Nodes")
@export var tile_packed_scene: PackedScene
@export var container: GridContainer

@export_group("Properties")
@export var board_size = 4

#*--------------- Fields ---------------*

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
	for i in range(board_size * board_size):
		var tile = tile_packed_scene.instantiate()
		container.add_child(tile)
		tile.generated()

	pass
