extends Entity

enum States {IDLE, RUN, JUMP, FALL, ATTACK}

@export var speed: float = 1000.0
@export var gravity: float = ProjectSettings.get_setting('physics/2d/default_gravity')
@export var jump_velocity: float = -1500.0
@export var knockback_velocity: Vector2 = Vector2(1500, -1500)


@export var jump_hang_time: float = 0.15
var hang_time_remaining: float = 0.0

@export var jump_input_buffer: float = 0.15
var input_buffer_remaining: float = 0.0

var can_attack: bool = true
var input_disabled: bool = false
var did_get_hit: bool = false
#1 to right , -1 to left like get axis
var hit_direction: int = 1


@onready var pivot: Node2D = $Pivot
@onready var animation_player = $AnimationPlayer
@onready var state_machine: StateMachine = $StateMachine
@onready var footstep_sfx = $Sounds/Footstep
@onready var attack_timer: Timer = $AttackTimer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super._ready()
	state_machine.add_state(States.IDLE, $StateMachine/Idle)
	state_machine.add_state(States.RUN, $StateMachine/Run)
	state_machine.add_state(States.JUMP, $StateMachine/Jump)
	state_machine.add_state(States.FALL, $StateMachine/Fall)
	state_machine.add_state(States.ATTACK, $StateMachine/Attack)
	state_machine.initialize(self, States.IDLE)
	on_damage_taken.connect(_on_damage_taken)


func _physics_process(delta: float) -> void:
	super(delta)
	if not input_disabled:
		var direction = Input.get_axis('move_left', 'move_right')

		if direction > 0:
			pivot.scale.x = 1
		elif direction < 0:
			pivot.scale.x = -1
		
		velocity.x = direction * speed
	
	if not is_on_floor():
		if hang_time_remaining > 0:
			velocity.y = jump_velocity
			hang_time_remaining -= delta
		else:
			velocity.y += gravity

	if input_buffer_remaining > 0.0:
		input_buffer_remaining -= delta
	move_and_slide()

func jump() -> bool:
	if input_buffer_remaining > 0.0 and is_on_floor():
		velocity.y = jump_velocity
		hang_time_remaining = jump_hang_time
		return true
	return false


func is_falling() -> bool:
	return velocity.y > 250.0

func attack() -> bool:
	if not input_disabled and can_attack and Input.is_action_just_pressed('attack'):
		attack_timer.start()
		can_attack = false
		return true
	return false

func knockback() -> bool:
	if did_get_hit:
		input_disabled = true
		velocity = Vector2(knockback_velocity.x * hit_direction, knockback_velocity.y)
		return true
	return false

func _on_damage_taken(attacker: Node2D):
	did_get_hit = true
	var direction_to_attacker: Vector2 = attacker.global_position.direction_to(global_position)
	hit_direction = -1 if direction_to_attacker.x < 0 else 1
	knockback()


func _unhandled_input(event: InputEvent) -> void:
	if not input_disabled and event.is_action_pressed('jump'):
		input_buffer_remaining = jump_input_buffer


func _on_attack_timer_timeout() -> void:
	can_attack = true
