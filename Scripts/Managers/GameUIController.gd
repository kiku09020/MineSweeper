#*--------------- Extend ---------------*
extends CanvasLayer

#*--------------- Extported Fields ---------------*
@export_group("Labels")
@export var flag_count_label: Label
@export var timer_label: Label

@export_group("Nodes")
@export var rigid_body: RigidBody2D

@export_group("Properties")
@export var flag_count_label_minus_color: Color
@export var flag_count_label_color := Color.WHITE

#*--------------- Fields ---------------*

#*--------------- Signals ---------------*

#*--------------- Events ---------------*
func _ready() -> void:
	flag_count_label_color = flag_count_label.label_settings.font_color
	pass

#*--------------- Methods ---------------*
## タイマーラベルセット
func set_timer_label(time: int):
	var format_str = "🕒 %03d"
	timer_label.text = format_str % time
	pass

#------------------------------------------------------------

func _on_board_on_rest_mine_count_changed(flag_count: int) -> void:
	flag_count_label.text = "🚩 " + str(flag_count)

	# テキスト色変更
	var label_settings = flag_count_label.label_settings.duplicate()

	if flag_count < 0:
		label_settings.font_color = flag_count_label_minus_color
	else:
		label_settings.font_color = flag_count_label_color
	
	flag_count_label.label_settings = label_settings

func _on_game_timer_on_time_changed(time) -> void:
	set_timer_label(time)

func _on_game_manager_on_gameover() -> void:
	rigid_body.sleeping = false
	pass # Replace with function body.
