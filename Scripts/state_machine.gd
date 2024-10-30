extends Node
class_name StateMachine

@onready var node_to_control = self.owner

@export_node_path("Node") var initial_state
@onready var state = get_node(initial_state)

@export var DEBUG : bool = true
@export var PRINT_HISTORY : bool = false
var history = []

func _ready() -> void:
	call_deferred("_enter_state")
	pass

func _enter_state():
	if DEBUG:
		print(owner.name, ": Entering state: ", state.name)
	
	state.node = node_to_control
	state.state_machine = self
	state.enter()

func change_to(new_state):
	history.append(state.name)
	state = get_node(new_state)
	_enter_state()
	if PRINT_HISTORY:
		print(history)

func _process(delta: float) -> void:
	if state.has_method("process"):
		state.process(delta)

func _physics_process(delta: float) -> void:
	if state.has_method("physics_process"):
		state.physics_process(delta)

func _input(event: InputEvent) -> void:
	if state.has_method("input"):
		state.input(event)

func _unhandled_input(event: InputEvent) -> void:
	if state.has_method("unhandled_input"):
		state.unhandled_input(event)

func _unhandled_key_input(event: InputEvent) -> void:
	if state.has_method("unhandled_key_input"):
		state.unhandled_key_input(event)
