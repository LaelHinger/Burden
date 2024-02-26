extends KinematicBody2D
onready var sprite = $Sprite
onready var fireball = $Fireball
onready var corruption_bar = $"../GameCanvas/PlayerUI/CorruptionBar"
onready var animation = $AnimationPlayer

onready var timer = $Player_Audio/Footsteps/Timer
onready var dash_timer = $DashTimer_Holder/DashTimer

onready var playeraudio = $Player_Audio/Footsteps

var climbing: bool = false;


# Player variables
var speed: float = 150  # Adjust the speed as needed
const dash_speed = 900
var gravity: float = 800  # Adjust the gravity force as needed
var jump_speed: float = 300  # Adjust the jump force as needed
var velocity: Vector2 = Vector2()

var is_on_ground: bool = false
var dash_direction = Vector2.ZERO
var can_move: bool = true

var maxHealth: int = 3
var currentHealth: int = 3
var heartUI: Array

var is_dashing = false

export var CorruptionLevel: int = 0

onready var heart_1 = $"%Heart1"
onready var heart_2 = $"%Heart2"
onready var heart_3 = $"%Heart3"



var has_herbs: bool = false
var has_tales: bool = false
var has_ore: bool = false
var has_money: bool = false


var bool_dict = {}


onready var SFX = $"../SFX/AudioStreamPlayer"


onready var game_manager = $"%GameManager"



func _ready():
	fireball.visible = false
	
# Assuming the hearts are direct children of the current node
	heartUI = [heart_1, heart_2, heart_3]


# Called every frame
func _process(delta):
	#
	# Get player input
	var input_vector = Vector2()

	var right = Input.is_action_pressed("Move_Right")
	var left = Input.is_action_pressed("Move_Left")
	var jump = Input.is_action_pressed("Move_Jump")
	var dash = Input.is_action_pressed("Dash")
	var slash = Input.is_action_pressed("Left_Click")
	var cleanse = Input.is_action_pressed("Cleanse")
	var climb_up = Input.is_action_pressed("move_up")
	var climb_down = Input.is_action_pressed("move_down")
	
	if(can_move):
		if right:
			input_vector.x += 1
			dash_direction.x = 1
			animation.play("Run")
			$Sprite.flip_h = false;
		if left:
			input_vector.x -= 1
			dash_direction.x = -1
			animation.play("Run")
			$Sprite.flip_h = true;
					
		if !left && !right:
			animation.play("Idle")
			playeraudio.stop()
			dash_direction.x = 0
		if !is_on_ground:
			playeraudio.stop()
			
		if left || right:
			if (timer.time_left <= 0):
				playeraudio.pitch_scale = rand_range(0.8, 1.2);
				playeraudio.play()
				timer.start(0.4)
		if dash:
			if(!is_dashing):
				startDashTimer()
				velocity.x = input_vector.x * 500
			

			
		if !is_dashing:
			velocity.x = input_vector.x * speed
			
		if slash:
			if(left):
				$Sword.scale.x = -1
				$Sword/Sword_Area2D.monitorable = true;
				$Sword/Sword_Area2D.monitoring = true;
			else:
				$Sword.scale.x = 1	
				$Sword/Sword_Area2D.monitorable = true;
				$Sword/Sword_Area2D.monitoring = true;
		
		if !slash:
			$Sword/Sword_Area2D.monitorable = false;
			$Sword/Sword_Area2D.monitoring = false;
			

		if jump:
			animation.play("Jump")
		if !jump && !is_on_ground:
			animation.play("Fall")
		# Update the player velocity with gravity
		velocity.y += gravity * delta
		
		if climbing:
			if climb_up:
				position.y -= 5
				velocity.y = 0  # Disable gravity while climbing up
				
			elif climb_down:
				position.y += 5
				velocity.y = 0  # Disable gravity while climbing down
				
			else:
				velocity.y = 0  # Disable gravity when not climbin
		
		if cleanse:
			
			pass

		# Check if the player is on the ground
		is_on_ground = is_on_floor()

		# Jumping
		if is_on_ground and jump:
			velocity.y = -jump_speed
			
			
		if(Input.is_action_just_pressed("ui_page_up")):
			add_corruption(10)



		velocity = move_and_slide(velocity, Vector2.UP)
	
		
		
		
		
	
func startDashTimer():
	is_dashing = true
	dash_timer.start()

		
		
		
func take_damage(damage: int):
	currentHealth -= damage
	update_heart_display();
	checkHealth();

	
func update_heart_display():
	# Update the heart UI based on current health
	for i in range(maxHealth):
		if i < currentHealth:
			heartUI[i].visible = true  # Show hearts up to the current health
		else:
			heartUI[i].visible = false  # Hide remaining hearts
			
func checkHealth():
	if (currentHealth <= 0):
		game_manager.gameOver();
		
		
func add_corruption(amount: float):
	# Update the experience value
	corruption_bar.value += amount
	CorruptionLevel += amount

	# Ensure the experience doesn't go beyond the maximum (if applicable)
	corruption_bar.value = min(corruption_bar.value, corruption_bar.max_value)
	game_manager._UpdateBG()


func grantBool(bool_name: String) -> void:
	# Set the boolean in the dictionary to true
	bool_dict[bool_name] = true
	print(bool_name)

# Function to check if a boolean is true
func hasBool(bool_name: String) -> bool:
	# Check if the boolean exists in the dictionary and is true
	return bool_dict.has(bool_name) and bool_dict[bool_name]

func _on_DashTimer_timeout():
	is_dashing = false
	
func _play_anim(animation_name) -> void:
	animation.play(animation_name)
	print("Playing: " + animation_name) 
func _stop_anim() -> void:
	animation.stop()
