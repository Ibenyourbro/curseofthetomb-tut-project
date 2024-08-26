extends Node

var heart = preload('res://collectables/heart.tscn')
var coin = preload('res://collectables/coin.tscn')

func initalize(enemies: Array[Node]):
	for enemy in enemies:
		enemy.on_death.connect(handle_enemy_death)

func spawn_collectable(location: Vector2):
	# Get a random number
	var random = randi() % 3

	match random:
		0:
			return
		1:
			var heart_instance = heart.instantiate()
			heart_instance.global_position = location
			call_deferred("add_child", heart_instance)
		2:
			var coin_instance = coin.instantiate()
			coin_instance.global_position = location
			call_deferred('add_child', coin_instance)


func handle_enemy_death(enemy: Entity):
	spawn_collectable(enemy.global_position)