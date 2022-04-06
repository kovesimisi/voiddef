extends Control

onready var b_single_new = $MarginContainer/VBoxContainer/SingleNewGameButton
onready var b_multi_new = $MarginContainer/VBoxContainer/MultiNewGameButton
onready var b_load = $MarginContainer/VBoxContainer/LoadButton
onready var b_settings = $MarginContainer/VBoxContainer/SettingsButton
onready var b_exit = $MarginContainer/VBoxContainer/ExitButton

func _ready():
	
	if OS.has_feature("HTML5"):
		b_exit.get_child(0).text = "TOGGLE FULLSCREEN"
		b_exit.disconnect("pressed", self, "_on_ExitButton_pressed")
		b_exit.connect("pressed", self, "_on_toggle_fullscreen")
	
	#b_multi_new.focus_mode = Control.FOCUS_NONE
	#b_multi_new.disabled = true
	
	b_load.focus_mode = Control.FOCUS_NONE
	b_load.disabled = true
	
	#b_settings.focus_mode = Control.FOCUS_NONE
	#b_settings.disabled = true
	
	b_single_new.grab_focus()


func _on_ExitButton_pressed():
	get_tree().quit(0)


func _input(event):
	if event.is_action_pressed("ui_cancel") and not OS.has_feature("HTML5"):
		get_tree().quit(0)


func _on_SingleNewGameButton_pressed():
	get_tree().change_scene("res://scenes/Single.tscn")


func _on_MultiNewGameButton_pressed():
	get_tree().change_scene("res://scenes/LocalMulti.tscn")
	

func _on_SettingsButton_pressed():
	get_tree().change_scene("res://scenes/UIscenes/Settings.tscn")

func _on_toggle_fullscreen():
	OS.window_fullscreen = !OS.window_fullscreen
