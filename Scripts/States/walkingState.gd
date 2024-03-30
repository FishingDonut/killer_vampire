class_name WalkingState
extends State

@export var player: CharacterBody2D

func Physics_update(_delta) -> void:
	if player.velocity == Vector2.ZERO:
		transitioned.emit(self,"idle")
