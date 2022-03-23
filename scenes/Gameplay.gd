extends Spatial

func _input(event):
	if event.is_action("ui_cancel"):
		get_tree().change_scene("res://scenes/UIscenes/MainMenu.tscn")
