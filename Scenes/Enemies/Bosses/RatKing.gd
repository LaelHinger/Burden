extends KinematicBody2D

onready var player = $"%Player"
onready var hit_timer = $HitTimer

onready var rat_spawn_timer = $RatSpawnTimer

var smolrat = preload("res://Scenes/PlaceholderEnemy2.tscn")

export var enemyHealth: int = 100
export var enemyDamage: int = 1 
export var enemyCorruptionUponDeath: float = 30

var movementSpeed: float = 120.0  
var gravity: Vector2 = Vector2(0, 980)  
var velocity: Vector2 = Vector2.ZERO

var PlayerInRange = false
var BattleStarted = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
func _process(delta):
	if player && PlayerInRange:
		# Get the direction from the enemy to the player
		var direction = player.global_position - global_position
		direction.y = 0  # Ignore the vertical component

		direction = direction.normalized()

		# Update velocity with movement and gravity
		velocity.x = direction.x * movementSpeed
		velocity += gravity * delta

		# Move the enemy using move_and_slide
		velocity = move_and_slide(velocity, Vector2.UP)

		

func _on_PlayerDetection_body_entered(body):
	if(body.name == "Player"):
		PlayerInRange = true
		BattleStarted = true
		rat_spawn_timer.start()


func _on_PlayerDetection_body_exited(body):
	if(body.name == "Player"):
		PlayerInRange = false
	pass # Replace with function body.
	
func _on_HitTimer_timeout():
	if(PlayerInRange == true):
		player.take_damage(enemyDamage)
	else:
		hit_timer.stop()

func _on_Hitrange_body_entered(body):
	if(body.name == "Player"):
		PlayerInRange = true;
		player.take_damage(enemyDamage)
		hit_timer.start()
		print("test")
		


func _on_Hitrange_body_exited(body):
	hit_timer.stop()


func _on_Hurtbox_area_entered(area):
	if area.get_parent().name == "Fireball":
		_take_damage(10)

func _take_damage(damage: int):
	enemyHealth = enemyHealth - damage
	if enemyHealth <= 0:
		player.add_corruption(enemyCorruptionUponDeath)
		queue_free()


func spawnrats():
	
	for n in range(5):  # Adjust the number of enemies as needed
		var new_rat = smolrat.instance()
		new_rat.position = Vector2(rand_range(-50, 50), rand_range(-50, 50))

		new_rat.visible = true
		new_rat.z_index = 1  # Adjust the value based on your scene's requirements
		add_child(new_rat)

		
		# Additional setup or customization for small enemies can be done here

		





func _on_RatSpawnTimer_timeout():
	spawnrats()
