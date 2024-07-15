#*--------------- Extend ---------------*
extends CanvasLayer

#*--------------- Extported Fields ---------------*
@export var flag_count_label: Label

#*--------------- Fields ---------------*

#*--------------- Signals ---------------*

#*--------------- Events ---------------*
func _ready() -> void:
	pass

func _process(_delta: float) -> void:
	pass

# Input
func _input(_event: InputEvent) -> void:
	pass

#*--------------- Methods ---------------*

func _on_board_on_rest_mine_count_changed(flag_count: int) -> void:
	flag_count_label.text = str(flag_count)
