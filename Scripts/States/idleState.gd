class_name  IdleState
extends State

@export var player: CharacterBody2D
@export var anim: AnimationPlayer

var state_name: String = "idle"
var state_anim := "idle_down"
func Enter() -> void:
	anim.play(state_anim)

func Physics_update(_delta) -> void:
	_direction()
	if player.velocity != Vector2.ZERO:
		transitioned.emit(self, "walking")

func _direction() -> void:
	if player.direction:
		var direction = player.direction
		if direction.x != 0:
			state_anim = state_name + "_x"
		elif direction.y > 0:
			state_anim = state_name + "_down"
		elif direction.y < 0:
			state_anim = state_name + "_up"
		else:
			anim.play(state_anim)
