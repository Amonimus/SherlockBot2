class_name BotMemory
extends Node

var enviroments: Array
var current_env: int = 0

class Env:
	var id: int
	var known_objects: Array
	
	func _init():
		pass
	
	func _to_string():
		return "Env"

func _init():
	enviroments.append(Env.new())

func get_current_env() -> Env:
	return enviroments[current_env]

func memorize_object(obj: Object):
	var env: Env = get_current_env()
	if not obj in env.known_objects:
		env.known_objects.append(obj)
