extends State

# Called whenever we enter a given state
# I.E Start an Animation
func _enter(previous_state, host):
    host.animation_player.play('walk')
    pass

# Called whenever we exit a given state
# I.E Cleanup task
func _exit(new_state, host):
    pass

# Called every physics frame for current state
# I.E Work done in process function
func _execute(delta, host):
    pass

# Determines if we need to change state, or stay in same state
# I.E If still pressing run button, keep running or
# if we stop pressring run button, change to idle
func _get_next_state(host):
    return null