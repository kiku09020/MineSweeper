#*--------------- Extend ---------------*
extends Node

#*--------------- Extported Fields ---------------*

#*--------------- Fields ---------------*

#*--------------- Signals ---------------*

#*--------------- Events ---------------*
func _ready() -> void:
	pass

func _process(_delta: float) -> void:
	pass

# Input
func _input(_event: InputEvent) -> void:
	# 終了
	if _event.is_action_pressed("ui_cancel"):
		get_tree().quit()

	# リトライ
	if _event.is_action_pressed("retry"):
		get_tree().reload_current_scene()

	pass

#*--------------- Methods ---------------*
