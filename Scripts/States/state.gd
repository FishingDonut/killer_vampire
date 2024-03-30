class_name State
extends Node


signal transitioned(state: State, nes_state_name: StringName)


func Enter() -> void:
	pass


func Exit() -> void:
	pass


func Update(delta: float) -> void:
	pass


func Physics_update(delta: float) -> void:
	pass
