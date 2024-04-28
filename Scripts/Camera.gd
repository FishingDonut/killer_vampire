extends Node2D
class_name Camera

@onready var camera = $Camera

@export var zoom_camera: float = 1.0

func _ready():
	camera.zoom = Vector2(zoom_camera, zoom_camera)
	Global.camera = self


func _process(delta):
	pass
