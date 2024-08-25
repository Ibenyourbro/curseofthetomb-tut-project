extends State

# Called whenever we enter a given state
# I.E Start an Animation
func _enter(previous_state, host):
    host.animation_player.play('knockback')
    host.input_disabled = true
    host.did_get_hit = false
    host.velocity.x = host.knockback_velocity.x * host.hit_direction
    host.velocity.y = host.knockback_velocity.y

# Called whenever we exit a given state
# I.E Cleanup task
func _exit(new_state, host):
    host.input_disabled = false

# Called every physics frame for current state
# I.E Work done in process function
func _execute(delta, host):
    pass

# Determines if we need to change state, or stay in same state
# I.E If still pressing run button, keep running or
# if we stop pressring run button, change to idle
func _get_next_state(host):
    if host.knockback_time_remaining <= 0.0:
        return host.States.IDLE
    return null