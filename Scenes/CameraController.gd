#*--------------- Extend ---------------*
extends Camera2D

#*--------------- Extported Fields ---------------*
@export_group("Shaking")
@export var shake_strength = 0.5
@export var shake_fade = 10

#*--------------- Fields ---------------*
var current_shake_strength = 0

#*--------------- Signals ---------------*

#*--------------- Events ---------------*

func _process(delta: float) -> void:
	if current_shake_strength > 0:
		current_shake_strength = lerpf(current_shake_strength, 0, delta * shake_fade)
		shake_camera()

#*--------------- Methods ---------------*

func shake_camera():
	offset = Vector2(randf_range( - current_shake_strength, current_shake_strength), randf_range( - current_shake_strength, current_shake_strength))

## カメラ振動開始
func start_shaking():
	current_shake_strength = shake_strength

func _on_game_manager_on_gameover() -> void:
	start_shaking()
	pass # Replace with function body.
