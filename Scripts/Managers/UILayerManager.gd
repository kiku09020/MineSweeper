#*--------------- Extend ---------------*
extends Node
class_name UILayerManager

#*--------------- Extported Fields ---------------*
@export_group("Layers")
@export var board_layer: CanvasLayer
@export var game_ui_layer: CanvasLayer
@export var gameover_layer: CanvasLayer
@export var gameclear_layer: CanvasLayer

@export_group("Properties")
@export var hide_game_ui_layer = false

#*--------------- Fields ---------------*

#*--------------- Signals ---------------*

#*--------------- Events ---------------*
func _ready() -> void:
	gameover_layer.hide()
	gameclear_layer.hide()
	pass

#*--------------- Methods ---------------*
## レイヤー表示アニメーション
func play_show_layer_animation(layer: CanvasLayer):
	pass

#------------------------------------------------------------

func _on_game_manager_on_gameover() -> void:
	if hide_game_ui_layer: game_ui_layer.hide()
	gameover_layer.show()

func _on_game_manager_on_gameclear() -> void:
	if hide_game_ui_layer: game_ui_layer.hide()
	gameclear_layer.show()
