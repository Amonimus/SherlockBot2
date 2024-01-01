extends Node3D

func _ready():
	disable_rednering()
	add_child(InteractiveObject.new(randi() % 20 - 10, randi() % 20 - 10))
	add_child(InteractiveObject.new(randi() % 20 - 10, randi() % 20 - 10))
	add_child(InteractiveObject.new(randi() % 20 - 10, randi() % 20 - 10))
	add_child(InteractiveObject.new(randi() % 20 - 10, randi() % 20 - 10))
	add_child(InteractiveObject.new(randi() % 20 - 10, randi() % 20 - 10))
	add_child(InteractiveObject.new(randi() % 20 - 10, randi() % 20 - 10))
	add_child(InteractiveObject.new(randi() % 20 - 10, randi() % 20 - 10))
	add_child(InteractiveObject.new(randi() % 20 - 10, randi() % 20 - 10))
	add_child(InteractiveObject.new(randi() % 20 - 10, randi() % 20 - 10))
	add_child(InteractiveObject.new(randi() % 20 - 10, randi() % 20 - 10))
	add_child(InteractiveObject.new(randi() % 20 - 10, randi() % 20 - 10))
	add_child(InteractiveObject.new(randi() % 20 - 10, randi() % 20 - 10))

func disable_rednering():
	get_viewport().debug_draw = Viewport.DEBUG_DRAW_UNSHADED
