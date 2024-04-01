class_name Player
extends CharacterBody2D


@onready var sprite = $Sprite as Sprite2D
@onready var anim = $Anim as AnimationPlayer
@onready var remote_camera = $RemoteCamera as RemoteTransform2D
@onready var progress_bar = $ProgressBar
@onready var state_machine = $StateMachine


#status
var speed_walk = 100.0
var max_hp := 100.0
var current_hp := max_hp

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


var direction := Vector2.ZERO


var is_dead: bool = false


signal update_hp(damage: float)
signal is_death

func _ready():
	Global.player = self
	update_hp.connect(_update_hp)
	is_death.connect(_is_death)
	remote_camera.remote_path = Global.camera.get_path()


func _physics_process(delta) -> void:
	if is_dead:
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

func _update_hp(damage) -> void:
	var tween_hp = get_tree().create_tween()
	current_hp -= damage
	progress_bar.value = current_hp / 100
	
	if max_hp != current_hp and current_hp / 100 >= 0.8:
		tween_hp.tween_property(progress_bar, "modulate", Color(0, 1, 0, 1), 0.2)
	
	elif current_hp / 100 >= 0.4:
		tween_hp.tween_property(progress_bar, "modulate", Color(1, 1, 0, 1), 0.2)
	
	elif current_hp / 100 <= 0.4:
		tween_hp.tween_property(progress_bar, "modulate", Color(1, 0, 0, 1), 0.2)

	else:
		tween_hp.tween_property(progress_bar, "modulate", Color(1, 0, 0, 0), 0.2)
	
	if current_hp <= 0.0:
		state_machine.is_death.emit()

func _is_death():
	is_dead = true
