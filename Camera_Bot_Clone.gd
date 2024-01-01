extends Camera3D

@onready var scene: Node3D = get_owner()
@onready var camera: Camera3D = scene.find_child("Camera_Bot")

func _process(_delta):
	global_position = camera.global_position
	global_rotation = camera.global_rotation
