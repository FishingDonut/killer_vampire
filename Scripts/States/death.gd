class_name DeathState
extends State

@export var player: CharacterBody2D
@export var anim: AnimationPlayer

var state_name: String = "death"

func Enter() -> void:
	anim.play(state_name)
