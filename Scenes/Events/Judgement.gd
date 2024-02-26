extends Area2D
onready var game_manager = $"%GameManager"
onready var player = $"%Player"
onready var animation_player = $"../../CutsceneHolder/Ending1/AnimationPlayer"

var animation_playing: bool = false

func _on_Area2D_body_entered(body):
	if(body.name == "Player"):
		if(player.CorruptionLevel == 0):
			pass
			#if(!animation_playing):
				#animation_player.play("Ending1")
				#animation_playing = true;
				#player.can_move = false;
		if(player.CorruptionLevel > 0 && player.CorruptionLevel <= 25 ):
			print("Ending 1")
		if(player.CorruptionLevel > 25 && player.CorruptionLevel <= 50 ):
			print("Ending 2")
		if(player.CorruptionLevel > 50 && player.CorruptionLevel <= 75 ):
			print("Ending 3")
		if(player.CorruptionLevel > 75 && player.CorruptionLevel <= 100 ):
			print("Ending 4")
			


