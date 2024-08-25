extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$HUD.intialize($Player)
	$HUD.set_health_sprites($Player.current_health)
