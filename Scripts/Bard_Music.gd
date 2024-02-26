extends Node2D

export var Soundclip1 : AudioStreamMP3
export var Soundclip2 : AudioStreamMP3
export var Soundclip3 : AudioStreamMP3
export var Soundclip4 : AudioStreamMP3
export var Soundclip5 : AudioStreamMP3
export var Soundclip6 : AudioStreamMP3
export var Soundclip7 : AudioStreamMP3
export var Soundclip8 : AudioStreamMP3
export var Soundclip9 : AudioStreamMP3
export var Soundclip10 : AudioStreamMP3
export var Soundclip11 : AudioStreamMP3

onready var timer = $Timer
onready var audio_player = $AudioStreamPlayer2D
onready var bard = $".."


func _ready():
	randomize()
	start_timer()

func start_timer():
	var min_wait_time = 1.0  # Minimum wait time in seconds
	var max_wait_time = 3.0  # Maximum wait time in seconds

	# Set the timer wait time to a random value within the specified range
	timer.wait_time = rand_range(min_wait_time, max_wait_time)
	timer.start()

func _on_Timer_timeout():
	if(!bard.corruption_added):
		# Choose a random sound clip to play
		var random_clip = randi() % 10 + 1

		match random_clip:
			1:
				audio_player.stream = Soundclip1
			2:
				audio_player.stream = Soundclip2
			3:
				audio_player.stream = Soundclip3
			4:
				audio_player.stream = Soundclip4
			5:
				audio_player.stream = Soundclip5
			6:
				audio_player.stream = Soundclip6
			7:
				audio_player.stream = Soundclip7
			8:
				audio_player.stream = Soundclip8
			9:
				audio_player.stream = Soundclip9
			10:
				audio_player.stream = Soundclip10

		# Play the selected sound clip
		audio_player.play()

		# Restart the timer for the next iteration
		start_timer()
	else:
		audio_player.stop()
