extends KinematicBody2D


var enemyRange: float = 100
export var enemyHealth: int = 20
onready var player = $"%Player"

var movementSpeed: float = 300.0  # Adjust the movement speed as needed
var gravity: Vector2 = Vector2(0, 980)  # Adjust the gravity value as needed
var velocity: Vector2 = Vector2.ZERO

func _ready():
	# Add the enemy to the "enemies" group
	add_to_group("enemies")

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

		# Optional: Rotate the enemy to face the player
		rotation = direction.angle()

func _on_Area2D_area_entered(area):
	_take_damage(10)

func _take_damage(damage: int):
	enemyHealth = enemyHealth - damage
	if enemyHealth <= 0:
		queue_free()
