extends Spatial

onready var world_boundaries_node = $Ground/StaticBody/WorldBoundaries

func _input(event):
	if event.is_action("ui_cancel"):
		get_tree().change_scene("res://scenes/UIscenes/MainMenu.tscn")

func _ready():
	GameManager.world_boundaries = world_boundaries_node.shape.extents
	GlobalAudioPlayer.play_music("game")
