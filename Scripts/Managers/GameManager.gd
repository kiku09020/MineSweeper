#*--------------- Extend ---------------*
extends Node

#*--------------- Extported Fields ---------------*

#*--------------- Fields ---------------*
var is_gameover = false
var is_gameclear = false

#*--------------- Signals ---------------*
signal on_gameover
signal on_gameclear

#*--------------- Events ---------------*
func _ready() -> void:
	pass

#*--------------- Methods ---------------*

#------------------------------------------------------------

func _on_board_on_mine_clicked() -> void:
	if is_gameover or is_gameclear: return

	# 爆弾クリックしたら、ゲームオーバー
	is_gameover = true
	on_gameover.emit()

func _on_board_on_cleared_all_tiles() -> void:
	if is_gameover or is_gameclear: return

	# 全てのタイルをクリアしたら、ゲームクリア
	is_gameclear = true
	on_gameclear.emit()
