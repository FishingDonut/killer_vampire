class_name DeathState
extends State

@export var player: CharacterBody2D
@export var anim: AnimationPlayer

var state_name: String = "death"
var damage: float = 0.0

func Enter() -> void:
	player.is_death.emit()
	anim.play(state_name)
