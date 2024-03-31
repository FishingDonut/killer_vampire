class_name Player
extends CharacterBody2D


@onready var sprite = $Sprite as Sprite2D
@onready var anim = $Anim as AnimationPlayer
@onready var remote_camera = $RemoteCamera as RemoteTransform2D
@onready var progress_bar = $ProgressBar


#status
var speed_walk = 10.0
var max_hp := 100.0
var current_hp := max_hp


var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


var direction := Vector2.ZERO


var is_death := false
var is_hurt := false


func _ready():
	Global.player = self
	remote_camera.remote_path = Global.camera.get_path()


func _physics_process(delta) -> void:

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
	current_hp += damage
	if max_hp != current_hp:
		var tween_hp = get_tree().create_tween()
		tween_hp.tween_property(progress_bar, "visible", true, 0.5)
	else:
		var tween_hp = get_tree().create_tween()
		tween_hp.tween_property(progress_bar, "visible", false, 0.5)
	
	if max_hp <= 0:
		pass
