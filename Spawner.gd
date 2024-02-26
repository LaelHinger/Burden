extends Node2D

var smolrat = preload("res://Scenes/PlaceholderEnemy2.tscn")

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():

	for n in range(5):  # Adjust the number of enemies as needed
		var new_rat = smolrat.instance()
		new_rat.position = Vector2(rand_range(-40, 40), rand_range(-40, 40))
		add_child(new_rat)
	

		new_rat.visible = true
		new_rat.z_index = 1  # Adjust the value based on your scene's requirements


		
		# Additional setup or customization for small enemies can be done here

		print(new_rat.position)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
