class_name InteractiveObject
extends Area3D

var interactions: Dictionary = {
	"poke": poke
}

func _init(x: int, y: int):
	position = Vector3(x, 0, y)
	create_box()

func create_box():
	var collision_shape = CollisionShape3D.new()
	collision_shape.shape = BoxShape3D.new()
	add_child(collision_shape)
	
	var mesh_shape = CSGBox3D.new()
	mesh_shape.material = StandardMaterial3D.new()
	mesh_shape.material.albedo_color = Color.CYAN
	add_child(mesh_shape)

func poke():
	return "Poke"
