#*--------------- Extend ---------------*
extends Node

#*--------------- Extported Fields ---------------*

#*--------------- Fields ---------------*
var time: float = 0
var sec_time: float = 0

var timer_started = false

#*--------------- Signals ---------------*
signal on_time_changed(time: int)

#*--------------- Events ---------------*
func _ready() -> void:
	pass

func _process(_delta: float) -> void:
	set_time(_delta)

#*--------------- Methods ---------------*

func set_time(_delta: float):
	# タイマー開始フラグが立っていない場合、処理しない
	if not timer_started: return

	time += _delta
	sec_time += _delta

	# 1秒経過でシグナル発行
	if sec_time >= 1:
		sec_time = 0
		on_time_changed.emit(int(time))

# ゲーム開始時にタイマー開始
func _on_game_manager_on_game_started() -> void:
	timer_started = true
