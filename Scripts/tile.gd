#*--------------- Extend ---------------*
extends Panel
class_name Tile

#*--------------- Extported Fields ---------------*
@export var button: Button

#*--------------- Fields ---------------*
## クリアフラグ
var is_cleared = false

#*--------------- Signals ---------------*

#*--------------- Methods ---------------*
func generated():
	pass

func _on_button_pressed() -> void:
	if is_cleared: return

	is_cleared = true
	button.visible = false
	pass # Replace with function body.
