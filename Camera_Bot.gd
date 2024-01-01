extends Camera3D

@onready var sherlock_bot: SherlockBot = get_owner().get_node("SherlockBot")

func _process(_delta):
	position = sherlock_bot.position + Vector3(1, 0, 0)
