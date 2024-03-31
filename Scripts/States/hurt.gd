class_name HurtState
extends State

@export var player: CharacterBody2D
@export var anim: AnimationPlayer

var state_name: String = "hurt"
var delta_time := 0.0
var interval_time := 1.0

func Enter() -> void:
	anim.play(state_name)

func Physics_update(_delta) -> void:
	pass
