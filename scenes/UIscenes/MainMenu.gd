extends Control

onready var b_new = get_node("MarginContainer/VBoxContainer/NewGameButton")

func _ready():
	b_new.grab_focus()

func _on_NewGameButton_pressed():
	get_tree().change_scene("res://scenes/Main.tscn")


func _on_ExitButton_pressed():
	get_tree().quit(0)
	
func _input(event):
	if event.is_action_pressed("ui_cancel"):
		get_tree().quit(0)
