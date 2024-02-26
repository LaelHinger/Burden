extends Button

export var Level1 = preload("res://Level1.tscn")

func _on_Button_pressed():
	get_tree().change_scene_to(Level1)


