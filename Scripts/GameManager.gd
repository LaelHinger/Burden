extends Node

onready var player_ui = $"%PlayerUI"
onready var game_over_ui = $"%GameOver"
onready var player = $"%Player"

onready var FARBG_Color = $"../BGS/EvenFurther/Sprite" #4d78af
onready var BG_Color =  $"../BGS/FARBG2/Sprite" #0f3668
onready var BG_Color2 = $"../BGS/FARBG1/Sprite" #05285b
onready var PlayableLayerColor = $"../BGS/PlayableLayerBG/Sprite" #08083b



func _ready():
	game_over_ui.visible = false
	player_ui.visible = true
	
func _process(delta):
	pass



		
func _UpdateBG():
	# Map the CorruptionLevel to a range between 0.0 and 1.0
	var color_factor: float = player.CorruptionLevel / 100.0

	# Gradually scale the red component towards 1.0
	FARBG_Color.modulate.b = lerp(FARBG_Color.modulate.b, 1.0, color_factor/2)
	# Keep blue and green components constant
	FARBG_Color.modulate.r = FARBG_Color.modulate.r / 3 # Set to your preferred value
	FARBG_Color.modulate.g = FARBG_Color.modulate.g / 2
	
	
	BG_Color.modulate.b = lerp(BG_Color.modulate.b, 0.5, color_factor/2)
	# Keep blue and green components constant
	BG_Color.modulate.r = BG_Color.modulate.r / 2.5 # Set to your preferred value
	BG_Color.modulate.g = BG_Color.modulate.g / 3
	
	BG_Color2.modulate.b = lerp(BG_Color2.modulate.b, 0.3, color_factor/2)
	# Keep blue and green components constant
	BG_Color2.modulate.r = BG_Color2.modulate.r / 2.5 # Set to your preferred value
	BG_Color2.modulate.g = BG_Color2.modulate.g / 3
	
	
	PlayableLayerColor.modulate.b = lerp(PlayableLayerColor.modulate.b, 0.2, color_factor/2)
	# Keep blue and green components constant
	PlayableLayerColor.modulate.r = PlayableLayerColor.modulate.r / 2.5 # Set to your preferred value
	PlayableLayerColor.modulate.g = PlayableLayerColor.modulate.g / 3
	
	
	
	player.modulate.r = lerp(FARBG_Color.modulate.r, 1.0, color_factor/2)
	# Keep blue and green components constant
	player.modulate.b = FARBG_Color.modulate.b / 10 # Set to your preferred value
	player.modulate.g = FARBG_Color.modulate.g / 10


func gameOver():
	game_over_ui.visible = true
	#player_ui.visible = false

	print("Game Over")
	# reload the scene:
	#

