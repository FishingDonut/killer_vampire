class_name StateMachine
extends Node

@export var player: CharacterBody2D
@export var current_state: State

var states: Dictionary = {}

signal is_death

func _ready():
	is_death.connect(_is_death)
	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child
			child.transitioned.connect(on_child_transitioned)
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


func _on_hurt_box_body_entered(body):
	if body.is_in_group("enemies"):
		states["hurt"]._update_damage(body.damage)
		current_state.transitioned.emit(current_state, "hurt")


func _on_hurt_box_body_exited(body):
	if body.is_in_group("enemies"):
		current_state.transitioned.emit(current_state, "idle")


func _on_anim_animation_finished(anim_name):
	if anim_name  == "death":
		player.queue_free()

func _is_death():
	current_state.transitioned.emit(current_state, "death")
