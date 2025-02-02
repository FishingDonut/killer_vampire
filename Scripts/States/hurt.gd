class_name HurtState
extends State

@export var player: CharacterBody2D
@export var anim: AnimationPlayer

var state_name: String = "hurt"
var damage: float = 0.0

func Enter() -> void:
	pass

func Physics_update(_delta) -> void:
	player.update_hp.emit(damage)

func _update_damage(new_damage: float) -> void:
	damage = new_damage
