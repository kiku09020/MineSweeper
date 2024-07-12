#*--------------- Extend ---------------*
extends Panel
class_name Tile

#*--------------- Extported Fields ---------------*
@export_group("Nodes")
@export var button: Button
@export var label: Label

@export_group("Properties")
@export var mine_rate = .2

#*--------------- Fields ---------------*
var tile_position: Vector2i

## クリアフラグ
var is_cleared = false

## 爆弾フラグ
var is_mine = false

#*--------------- Signals ---------------*
signal on_button_clicked

#*--------------- Methods ---------------*
## 生成処理
func generated(_position: Vector2i):
	tile_position = _position
	pass

## 爆弾カウントセット
func set_mine_count(_count: int):
	if is_mine: return

	label.text = str(_count)

func set_mine():
	if is_cleared: return

	is_mine = randf_range(0, 1) < mine_rate
	if is_mine:
		label.text = "💣"

## クリック処理
func clicked():
	if is_cleared: return

	is_cleared = true
	button.visible = false

#------------------------------------------------------------

func _on_button_pressed() -> void:
	clicked()
	on_button_clicked.emit()
	pass # Replace with function body.
