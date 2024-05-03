class_name Player
extends CharacterBody2D


@onready var sprite = $Sprite as Sprite2D
@onready var anim = $Anim as AnimationPlayer
@onready var remote_camera = $RemoteCamera as RemoteTransform2D
@onready var progress_bar = $ProgressBar
@onready var state_machine = $StateMachine


#status
@export var speed_walk = 100.0
@export var max_hp: float = 100.0
@export var damage: float = 1.0
var current_hp


#experience
@onready var level : int = 1
@onready var experience : float = 0
@onready var total_experience : float = 0
@onready var required_experience = _get_required_experience(level + 1)


var direction := Vector2.ZERO
var is_death: bool = false
var flash_intensity := 0.0


signal update_hp(damage: float)
signal collect_xp(xp_value: float)


func _ready():
	Global.player = self
	progress_bar.max_value = (max_hp / max_hp ) * 100
	current_hp = max_hp
	update_hp.connect(_update_hp)
	collect_xp.connect(_gain_experience)
	remote_camera.remote_path = Global.camera.get_path()


func _physics_process(delta) -> void:
	if is_death:
		return
		
	_move_direction()
	_scale_direction()
	move_and_slide()


func _move_direction() -> void:
	direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down").normalized().round()
	if direction:
		velocity = direction * speed_walk
		return
	
	velocity.x = move_toward(velocity.x, 0, speed_walk)
	velocity.y = move_toward(velocity.y, 0, speed_walk)


func _scale_direction() -> void:
	if direction.x != 0:
		sprite.scale.x = direction.x

func _update_hp(amount) -> void:
	var tween_hp = get_tree().create_tween()
	
	if max_hp <= current_hp - amount:
		current_hp = max_hp
		progress_bar.visible = false
	else:
		progress_bar.visible = true
		current_hp -= amount
		_hit_flash()

	progress_bar.value = (current_hp / max_hp) * 100

	if max_hp != current_hp and (current_hp / max_hp) * 100 >= 80:
		tween_hp.tween_property(progress_bar, "modulate", Color(0, 1, 0, 1), 0.2)
	
	elif (current_hp / max_hp) * 100 >= 50:
		tween_hp.tween_property(progress_bar, "modulate", Color(1, 1, 0, 1), 0.2)
	
	elif (current_hp / max_hp) * 100 <= 50:
		tween_hp.tween_property(progress_bar, "modulate", Color(1, 0, 0, 1), 0.2)

	else:
		tween_hp.tween_property(progress_bar, "modulate", Color(1, 0, 0, 0), 0.2)
	
	if current_hp <= 0.0:
		is_death = true
		state_machine.is_death.emit()


func _hit_flash() -> void:
	flash_intensity = 1.0
	sprite.material.set_shader_parameter("flash_intensity", flash_intensity)
	await get_tree().create_timer(0.1).timeout
	flash_intensity = 0.0
	sprite.material.set_shader_parameter("flash_intensity", flash_intensity)


#system experience
func _get_required_experience(level: int):
	return  pow(level, 1.8) + level * 4


func _gain_experience(amount) -> void:
	total_experience += amount
	experience += amount
	while experience >= required_experience:
		experience -= required_experience
		_level_up()
		_update_hp(-max_hp)


func _level_up() -> void:
	level += 1
	required_experience = _get_required_experience(level + 1)
	var states := ["speed_walk", "max_hp", "damage"]
	var random_state = states[randi() % states.size()]
	set(random_state, get(random_state) * 1.2)
