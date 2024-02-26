extends Camera2D

# Camera parameters
var follow_speed: float = 5.0
var clamp_to_screen: bool = true

# Called every frame
func _process(delta):
	# Get the mouse position in global coordinates
	var target_position = get_global_mouse_position()

	# If clamping is enabled, constrain the target position to the screen
	if clamp_to_screen:
		target_position.x = clamp(target_position.x, 0, get_viewport_rect().size.x)
		target_position.y = clamp(target_position.y, 0, get_viewport_rect().size.y)

	# Interpolate the camera position towards the mouse
	position = position.linear_interpolate(target_position, follow_speed * delta)


