#*--------------- Extend ---------------*
extends Node

#*--------------- Extported Fields ---------------*

#*--------------- Fields ---------------*
var operatable = true

var debug_keys

#*--------------- Signals ---------------*
signal on_debug_input_f1

#*--------------- Events ---------------*

# Input
func _input(_event: InputEvent) -> void:
	# デバッグ入力判定
	debug_input_process(_event)

	# 終了
	if _event.is_action_pressed("ui_cancel"):
		get_tree().quit()

	# リトライ
	if _event.is_action_pressed("retry"):
		get_tree().reload_current_scene()

	# 操作不可の場合、処理しない
	if not operatable: return

	pass

#*--------------- Methods ---------------*
## デバッグ入力判定
func debug_input_process(_event: InputEvent):
	if _event.is_action_pressed("f1"):
		on_debug_input_f1.emit()

#------------------------------------------------------------
# ゲームオーバー時、操作不可にする
func _on_game_manager_on_gameover() -> void:
	operatable = false
	pass # Replace with function body.
