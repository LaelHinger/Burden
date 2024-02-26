extends State
onready var collision = $"../../PlayerDetection/CollisionShape2D"

var _player_entered: bool = false

func set_player_entered(value):
	_player_entered = value
	collision.set_deferred("disabled", value)

func get_player_entered():
	return _player_entered

