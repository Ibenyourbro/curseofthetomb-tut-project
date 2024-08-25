class_name Collectable extends Area2D


@export var attraction_speed: float = 150.0

var player: Player
var has_been_collected: bool = false
@onready var destroy_timer: Timer = $DestroyTimer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _physics_process(delta: float) -> void:
	if player != null:
		var direction = global_position.direction_to(player.global_position)
		global_position += direction * attraction_speed

func collect():
	has_been_collected = true
	$Collect.play_at_random_pitch()
	hide()
	$DestroyTimer.start()


func _on_attraction_zone_body_entered(body: Node2D) -> void:
	if body is Player:
		player = body


func _on_body_entered(body: Node2D) -> void:
	if body is Player and not has_been_collected:
		collect()


func _on_destroy_timer_timeout() -> void:
	queue_free()