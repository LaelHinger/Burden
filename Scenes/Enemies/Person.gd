extends Sprite
onready var player = null
var player_in_range = false
export var initial_dialogue = ""

export var rejected_dialogue = ""
export var released_dialogue = ""

export var reenter_dialogue = ""


export var bool_needed = ""
export var bool_given = ""
 
export var released_sprite: Texture

export var CompletedSound: AudioStream

onready var dialogue = $"%Dialogue"




onready var Player_Dialogue_Text = $"../../GameCanvas/Dialogue/Label"
var corruption_added: bool = false

func _ready():
	player = get_tree().get_root().get_node("Node2D/%Player")
		
		
func _process(delta):
	if(player_in_range):
		if(Input.is_action_pressed("Cleanse")):
			CleanseEnemy()

func _on_Area2D_body_entered(body):
	if(body.name == "Player"):
		if(corruption_added):
			dialogue.visible = true
			$Label.visible = true
			Player_Dialogue_Text.text = reenter_dialogue
			player_in_range = true
		else:
			dialogue.visible = true
			
			$Label.visible = true
			
			Player_Dialogue_Text.text = initial_dialogue
			player_in_range = true
	pass # Replace with function body.


func _on_Area2D_body_exited(body):
	pass # Replace with function body
	if(body.name == "Player"):
		dialogue.visible = false
		$Label.visible = false
		Player_Dialogue_Text.text = ""
		player_in_range = false

func CleanseEnemy():
	if(bool_needed == "" || player.hasBool(bool_needed)):
		dialogue.visible = true
		self.texture = released_sprite
		
		player.grantBool(bool_given)
		if(!corruption_added):
			player.add_corruption(10)
			corruption_added = true;
			Player_Dialogue_Text.text = released_dialogue
			$AudioStreamPlayer2D.stream = CompletedSound
			$AudioStreamPlayer2D.play()
			
	else:
		Player_Dialogue_Text.text = rejected_dialogue
	
	#queue_free()
	
