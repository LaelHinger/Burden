
extends Sprite

# Adjust this value to control the smoothness (0.0 for no lag, 1.0 for immediate response)
var lag_factor: float = 0.1

# Called every frame
func _process(delta):
	# Get the global mouse position
	var target_position = get_global_mouse_position()
	
	# Use linear interpolation to smoothly update the position
	global_position = global_position.linear_interpolate(target_position, lag_factor)
