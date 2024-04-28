class_name  IdleState
extends State

@export var player: CharacterBody2D
@export var anim: AnimationPlayer

var state_name: String = "idle"

func Enter() -> void:
	anim.play(state_name)

func Physics_update(_delta) -> void:
	if player.velocity != Vector2.ZERO:
		transitioned.emit(self, "walking")
