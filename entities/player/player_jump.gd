extends State

# Called whenever we enter a given state
# I.E Start an Animation
func _enter(previous_state, host):
    host.animation_player.play('jump')

# Called whenever we exit a given state
# I.E Cleanup task
func _exit(new_state, host):
    pass

# Called every physics frame for current state
# I.E Work done in process function
func _execute(delta, host):
    if not Input.is_action_pressed('jump'):
        host.velocity.y += host.jump_deceleration

# Determines if we need to change state, or stay in same state
# I.E If still pressing run button, keep running or
# if we stop pressring run button, change to idle
func _get_next_state(host):
    if host.attack():
        return host.States.ATTACK
    
    if host.knockback():
        return host.States.KNOCKBACK
    
    if host.is_falling():
        return host.States.FALL

    if host.is_on_floor():
        return host.States.IDLE

    return null