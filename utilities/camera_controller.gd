extends Camera2D

@export var base_offset: Vector2 = Vector2(0, -100)
@export var look_ahead_distance: int = 150
@export var look_ahead_speed: float = 2.0

var player: Player


func _ready() -> void:
	offset = base_offset

func _process(delta: float) -> void:
	var direction := 0.0
	if player != null and not player.input_disabled:
		direction = player.get_movement_direction()
	
	var look_ahead_offset: Vector2 = Vector2(direction * look_ahead_distance, 0)
	offset = offset.lerp(base_offset + look_ahead_offset, look_ahead_speed * delta)