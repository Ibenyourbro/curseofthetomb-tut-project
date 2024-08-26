extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$HUD.intialize($Player)
	$CollectableManager.initalize($Enemies.get_children())
