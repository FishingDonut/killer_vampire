extends CharacterBody2D
class_name Player


@onready var sprite = $Sprite
@onready var anim = $Anim
@onready var remote_camera = $RemoteCamera



var speed_walk = 10.0


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
