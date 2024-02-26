extends Area2D
onready var player = $"%Player"

export var scene_to_load1 = preload("res://Endings/Ending1.tscn")
export var scene_to_load2 = preload("res://Endings/BetterEnding2.tscn")
export var scene_to_load3 = preload("res://Endings/BetterEnding3.tscn")


func _on_CutsceneChanger_body_entered(body):
	if(body.name == "Player"):
		
		if (player.CorruptionLevel == 0):
			get_tree().change_scene_to(scene_to_load1)
		if (player.CorruptionLevel > 0 && player.CorruptionLevel < 100):
			get_tree().change_scene_to(scene_to_load2)
		if (player.CorruptionLevel >= 60):
			get_tree().change_scene_to(scene_to_load3)
		
		pass


func _on_CutsceneChanger_body_exited(body):
	if(body.name == "Player"):
		pass
