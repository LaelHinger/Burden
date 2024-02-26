extends Node2D


func _on_Area2D_body_entered(body):
	if(body.name == "Player"):
		body.climbing = true
		
		$LadderSFXTIMER.start()

	

func _on_Area2D_body_exited(body):
	if(body.name == "Player"):
		body.climbing = false
		$LadderSFXTIMER.stop()
		$AudioStreamPlayer2D.stop()
		


func _on_LadderSFXTIMER_timeout():
	$AudioStreamPlayer2D.play()
	pass # Replace with function body.
