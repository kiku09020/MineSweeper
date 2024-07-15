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

@export_group("Easing")
@export var easing_duration = .5
@export var transition_type: Tween.TransitionType
@export var easing_type: Tween.EaseType

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
	var tween = get_tree().create_tween()

	layer.show()

	var panel = layer.get_child(0) as Panel
	var panel_prev_scale = panel.scale
	panel.pivot_offset = panel.size / 2
	panel.scale = Vector2.ZERO
	tween.tween_property(panel, "scale", panel_prev_scale, easing_duration) \
		.set_trans(transition_type) \
		.set_ease(easing_type)

	pass

#------------------------------------------------------------

func _on_game_manager_on_gameover() -> void:
	if hide_game_ui_layer: game_ui_layer.hide()
	#gameover_layer.show()
	play_show_layer_animation(gameover_layer)

func _on_game_manager_on_gameclear() -> void:
	if hide_game_ui_layer: game_ui_layer.hide()
	# gameclear_layer.show()
	play_show_layer_animation(gameclear_layer)
