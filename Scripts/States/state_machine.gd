class_name StateMachine
extends Node

@export var player : CharacterBody2D
@export var current_state: State
var states: Dictionary = {}


func _ready():
	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child
			child.transitioned.connect(on_child_transitioned)
			print(states)
		else:
			push_warning("Isso nao e um State")
	current_state.Enter()


func on_child_transitioned(state, new_state_name: StringName) -> void:
	var new_state = states.get(new_state_name)

	if current_state != state:
		return 

	if new_state != null:
		if new_state != current_state:
			current_state.Exit()
 
			new_state.Enter()

			current_state = new_state
	else:
		push_warning("Called transition on a state that does not exist")


func _process(delta):
	current_state.Update(delta)


func _physics_process(delta):
	current_state.Physics_update(delta)
