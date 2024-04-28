class_name GhostEnemy
extends CharacterBody2D

@onready var animation = $Animation
@onready var sprite = $Sprite
@onready var hurt_area_collision = $HurtAreaCollision
@onready var spawn_xp = $SpawnXp


@export var move_speed: float
@export var max_hp: float


var direction: Vector2
var current_hp: float
var damage: float = 1.0
var is_death: bool = false
var is_hurt: bool = false


func  _ready():
	Global.counter_enemies += 1
	current_hp = max_hp
	hurt_area_collision.update_health.connect(_update_heart)

func _physics_process(delta) -> void:
	_state()
	
	if direction:
		velocity = direction * move_speed
	else:
		velocity.x = move_toward(velocity.x, 0, move_speed)
		velocity.y = move_toward(velocity.y, 0, move_speed)

	if round(direction.x) != 0:
		sprite.scale.x = round(direction.x)
		pass
		
	if is_death:
		return	
	
	move_and_slide()
	
	if !Global.player:
		return
	direction = (Global.player.position - position).normalized()

func _update_heart(damage: float) -> void:
	current_hp -= damage
	is_hurt = true
	if current_hp <= 0:
		is_death = true
		Global.counter_score += randi_range(100, 300)
		Global.counter_kill += 1
		Global.counter_enemies -= 1
		

func _state() -> void:
	var state = _direction("idle")
	
	if is_death:
		state = "death"
		
	elif is_hurt:
		state = "hurt"
	
	elif direction:
		state = _direction("walking")
	
	if animation.name != state:
		animation.play(state)


func _on_animation_animation_finished(anim_name):
	if anim_name == "death":
		spawn_xp.spawn_xp.emit()
		queue_free()
	elif anim_name == "hurt":
		is_hurt = false

func _direction(state_anim: String):
	var distance = abs(Global.player.position - position)
	if !direction:
		return state_anim
		
	if distance.x < distance.y:
		if direction.y > 0:
			return state_anim + "_down"
		elif direction.y < 0:
			return state_anim + "_up"
	else:
		if direction.x != 0:
			return state_anim + "_x"
	return state_anim
