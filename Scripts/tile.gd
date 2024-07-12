#*--------------- Extend ---------------*
extends Panel
class_name Tile

#*--------------- Extported Fields ---------------*
@export_group("Nodes")
@export var button: Button
@export var label: Label
@export var flag_label: Label

@export_group("Properties")
@export var mine_rate = .2

#*--------------- Fields ---------------*
var tile_position := Vector2i.ZERO
var count := 0

## クリアフラグ
var is_cleared = false

## 爆弾フラグ
var is_mine = false

## フラグフラグ
var is_flag = false

#*--------------- Signals ---------------*
signal on_button_clicked
signal on_flag_changed(is_flag: bool)

#*--------------- Methods ---------------*
## 生成処理
func generated(_position: Vector2i):
	tile_position = _position
	pass

## 爆弾カウントセット
func set_mine_count(_count: int):
	if is_mine: return

	count = _count
	label.text = str(_count)

## 爆弾セット
func set_mine():
	if is_cleared: return

	is_mine = true
	label.text = "💣"

## フラグセット
func set_flag():
	if is_cleared: return

	is_flag = !is_flag
	if is_flag:
		flag_label.text = "🚩"
	else:
		flag_label.text = ""

	on_flag_changed.emit(is_flag)

## クリア処理
func cleared():
	if is_cleared or is_flag: return

	is_cleared = true
	button.visible = false

#------------------------------------------------------------

func _on_button_pressed() -> void:
	cleared()
	on_button_clicked.emit()

# 右クリック判定用シグナル
func _on_button_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_RIGHT and event.pressed:
			set_flag()
