class_name SherlockBot
extends CSGSphere3D

@onready var scene: Node3D = get_owner()
@onready var memory: BotMemory = BotMemory.new()
@onready var Ray: RayCast3D = get_node("RayCast3D")

var state: String = "Idle"

var do_move: bool
var do_move_by_path: bool
var do_discovery: bool
var move_path: Array
var move_target: Vector2

var path_line: MeshInstance3D

var move_speed: float = 0.05
var snap_distance: float = 0.1

func _ready():
	add_to_move_path(3, 3)
	add_to_move_path(3, -3)
	add_to_move_path(-3, 3)
	add_to_move_path(-3, -3)
	do_move_by_path = true
	do_discovery = true
	
func _process(_delta) -> void:
	var has_moved: bool
	if do_move_by_path:
		move_by_path()
	if do_move and move_target:
		has_moved = move_to(move_target.x, move_target.y)
	if do_move_by_path and not has_moved:
		pop_move_path()
		
	if do_discovery and not do_move_by_path and memory.get_current_env().known_objects.size() > 0:
		state = "Approach"
		var obj = memory.get_current_env().known_objects[0]
		approach(position, obj)
		do_discovery = false
	
	set_state()

func _physics_process(_delta):
	ray_test()

func move_to(x: int, y: int) -> bool:
	var target_position: Vector3 = Vector3(x, 0, y)
	var direction: Vector3 = global_position.direction_to(target_position)
	if global_position.distance_to(target_position) > 0.1:
		smooth_rotation(direction)
		global_position += direction * move_speed
		draw_line(position, target_position)
		return true
	else:
		do_move = false
		return false

func set_move_target(x: int, y: int) -> void:
	move_target = Vector2(x, y)
	do_move = true

func add_to_move_path(x: int, y: int) -> void:
	move_path.append(Vector2(x, y))

func move_by_path():
	if move_path.size() > 0:
		var first_path_point: Vector2 = move_path[0]
		if first_path_point != move_target:
			set_move_target(first_path_point.x, first_path_point.y)
	else:
		do_move_by_path = false

func pop_move_path():
	if move_path.size() > 0:
		move_path.remove_at(0)
	else:
		do_move_by_path = false

func set_state():
	if do_move:
		state = "Moving"
	else:
		state = "Idle"

func ray_test():
	if Ray.is_colliding():
		var collision_object: Area3D = Ray.get_collider()
		if collision_object is InteractiveObject:
			memory.memorize_object(collision_object)

func smooth_rotation(direction: Vector3) -> void:
	var angle = atan2(-direction.x, -direction.z)
	rotation.y = lerp_angle(rotation.y, angle, move_speed)

func approach(from: Vector3, obj: Object):
	var direction: Vector3 = from.direction_to(obj.position)
	
	var angle = atan2(-direction.x, -direction.z)
	var step_point = obj.position - Vector3(cos(angle), 0, sin(angle)) * 2
	
	print(obj.position, " ", step_point, " " , obj.position.distance_to(step_point))
	#var step_point = obj.position - direction
	add_to_move_path(step_point.x, step_point.z)
	do_move_by_path = true

func draw_line(pos1: Vector3, pos2: Vector3):
	if path_line != null:
		path_line.queue_free()
	
	var mesh_instance = MeshInstance3D.new()
	var immediate_mesh = ImmediateMesh.new()
	var mesh_material = StandardMaterial3D.new()
	mesh_instance.mesh = immediate_mesh
	mesh_instance.cast_shadow = false
	immediate_mesh.surface_begin(Mesh.PRIMITIVE_LINES, mesh_material)
	immediate_mesh.surface_add_vertex(pos1)
	immediate_mesh.surface_add_vertex(pos2)
	immediate_mesh.surface_end()
	mesh_material.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	mesh_material.albedo_color = Color.BLUE
	scene.add_child(mesh_instance)
	path_line = mesh_instance
