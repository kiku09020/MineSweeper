#*--------------- Extend ---------------*
extends Node
class_name UILayerManager

#*--------------- Extported Fields ---------------*
@export_group("Layers")
@export var board_layer: CanvasLayer
@export var game_ui_layer: CanvasLayer
@export var gameover_layer: CanvasLayer
@export var gameclear_layer: CanvasLayer

#*--------------- Fields ---------------*

#*--------------- Signals ---------------*

#*--------------- Events ---------------*
func _ready() -> void:
	gameover_layer.hide()
	gameclear_layer.hide()
	pass

#*--------------- Methods ---------------*

func _on_game_manager_on_gameover() -> void:
	gameover_layer.show()

func _on_game_manager_on_gameclear() -> void:
	gameclear_layer.show()
