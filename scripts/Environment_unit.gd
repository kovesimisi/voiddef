extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var value = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func remove():
	queue_free()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
