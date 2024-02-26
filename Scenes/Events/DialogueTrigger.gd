extends Node2D

onready var player_dialogue = $"../GameCanvas/Dialogue/Label"
onready var dialogue = $"%Dialogue"



func _on_Area2D_body_entered(body):
	if(body.name == "Player"):
		dialogue.visible = true
		player_dialogue.text = "Upon entering this area, you cannot return."
		pass


func _on_Area2D_body_exited(body):
	if(body.name == "Player"):
		dialogue.visible = false
		player_dialogue.text = ""
		pass
