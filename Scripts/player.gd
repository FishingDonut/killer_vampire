extends CharacterBody2D
class_name Player


@onready var sprite = $Sprite
@onready var anim = $Anim
@onready var remote_camera = $RemoteCamera



const SPEED = 300.0
const JUMP_VELOCITY = -400.0


var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var direction := Vector2.ZERO

func _ready():
	Global.player = self
	remote_camera.remote_path = Global.camera.get_path()


func _physics_process(delta):

	_move_direction()
	move_and_slide()


func _move_direction() -> void:
	direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down").normalized().round()
	if direction:
		velocity = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.y = move_toward(velocity.y, 0, SPEED)
