extends KinematicBody2D

var enemyRange: float = 100
export var enemyHealth: int = 20
export var enemyDamage: int = 1 
export var enemyCorruptionUponDeath: float = 1
onready var player = null
onready var hit_timer = $HitTimer
var is_player_in_hitbox: bool = false

var Corrupt: bool = false


class_name PlaceholderEnemy2

var movementSpeed: float = 120.0  # Adjust the movement speed as needed
var gravity: Vector2 = Vector2(0, 980)  # Adjust the gravity value as needed
var velocity: Vector2 = Vector2.ZERO
export var timeBetweenHits: float = 1

func _ready():
	# Add the enemy to the "enemies" group
	add_to_group("enemies")
	player = get_tree().get_root().get_node("Node2D/%Player")



func _process(delta):
	if player:
		# Get the direction from the enemy to the player
		var direction = player.global_position - global_position
		direction.y = 0  # Ignore the vertical component

		direction = direction.normalized()

		# Update velocity with movement and gravity
		velocity.x = direction.x * movementSpeed
		velocity += gravity * delta

		# Move the enemy using move_and_slide
		velocity = move_and_slide(velocity, Vector2.UP)


func _on_Area2D_area_entered(area):
	if area.get_parent().name == "Fireball":
		Corrupt = true
		_take_damage(10)
	if area.get_parent().name == "Sword":
		Corrupt = false
		_take_damage(5)
	

func _take_damage(damage: int):
	enemyHealth = enemyHealth - damage
	
	if enemyHealth <= 0:
		if(Corrupt):
			player.add_corruption(enemyCorruptionUponDeath)
			print("Corrupted")
			print(player.CorruptionLevel)
		queue_free()
		
		


func _on_Hitbox_body_entered(body):
	if(body.name == "Player"):
		is_player_in_hitbox = true;
		player.take_damage(enemyDamage)
		hit_timer.start()
		

		
	
		



func _on_HitTimer_timeout():
	if(is_player_in_hitbox == true):
		player.take_damage(enemyDamage)
	else:
		hit_timer.stop()



func _on_Hitbox_body_exited(body):
	hit_timer.stop()
