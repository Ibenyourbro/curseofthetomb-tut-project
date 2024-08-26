extends Node

signal on_coins_changed(new_coin_amount: int)

# Creating a setter/getter in autoload/singleton
var coins: int = 0:
	set(value):
		coins = value
		on_coins_changed.emit(value)
