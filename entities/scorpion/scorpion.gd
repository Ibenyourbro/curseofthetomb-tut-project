extends Entity


enum States {PATROL, DIE}

@export var speed: float = 200.0
@export var gravity: float = ProjectSettings.get_setting('physics/2d/default_gravity')

var direction: float = 1

@onready var pivot: Node2D = $Pivot
@onready var animation_player = $AnimationPlayer
@onready var state_machine: StateMachine = $StateMachine
@onready var wall_check: RayCast2D = $Pivot/WallCheck
@onready var ground_check: RayCast2D = $Pivot/GroundCheck
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super()
	state_machine.add_state(States.PATROL, $StateMachine/Patrol)
	state_machine.add_state(States.DIE, $StateMachine/Die)
	state_machine.initialize(self, States.PATROL)
	on_damage_taken.connect(_on_damage_taken)


func _physics_process(delta: float) -> void:
	super(delta)
	if wall_check.is_colliding() or not ground_check.is_colliding():
		direction = -direction
	if direction > 0:
		pivot.scale.x = 1
	elif direction < 0:
		pivot.scale.x = -1

	velocity.x = direction * speed
	velocity.y += gravity
	move_and_slide()


func _on_damage_taken(attacker: Node2D):
	$Hit.play_at_random_pitch()
