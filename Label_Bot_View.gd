extends Label

@onready var scene: Node3D = get_owner()
@onready var bot: SherlockBot = scene.find_child("SherlockBot")
@onready var memory: BotMemory = bot.memory

func _process(_delta):
	var text_str: String = "STATE: %s\n" % bot.state
	text_str += "MEMORY: %s\n" % memory.get_current_env().known_objects.size()
	text = text_str
