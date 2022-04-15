extends Control

onready var b_single_new = $MarginContainer/VBoxContainer/SingleNewGameButton
onready var b_multi_new = $MarginContainer/VBoxContainer/MultiNewGameButton
onready var b_load = $MarginContainer/VBoxContainer/LoadButton
onready var b_join = $MarginContainer/VBoxContainer/JoinGameButton
onready var b_settings = $MarginContainer/VBoxContainer/SettingsButton
onready var b_exit = $MarginContainer/VBoxContainer/ExitButton
onready var p_target_uri_popup = $TargetURI
onready var p_target_uri = $TargetURI/VBoxContainer/TargetURIInput
onready var p_target_uri_popup_cancel = $TargetURI/VBoxContainer/HBoxContainer/CancelJoinButton
onready var p_target_uri_popup_join = $TargetURI/VBoxContainer/HBoxContainer/JoinButton

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
	
	p_target_uri_popup.popup_exclusive = true
	get_tree().connect("connected_to_server", self, "_on_connection_successful")
	get_tree().connect("connection_failed", self, "_on_connection_failed")
	
	if(!OS.has_feature("standalone")):
		p_target_uri.text = "localhost"
	
	b_single_new.grab_focus()

func _on_ExitButton_pressed():
	get_tree().quit(0)


func _input(event):
	if event.is_action_pressed("ui_cancel") and not OS.has_feature("HTML5"):
		get_tree().quit(0)


func _on_SingleNewGameButton_pressed():
	get_tree().change_scene("res://scenes/Single.tscn")


func _on_MultiNewGameButton_pressed():
	get_tree().change_scene("res://scenes/MultiSplitscreen.tscn")
	
func _on_HostGame_pressed():
	get_tree().change_scene("res://scenes/MultiHost.tscn")
	
func _on_JoinGame_pressed():
	p_target_uri_popup.popup_centered()
	
func _on_CancelJoinButton_pressed():
	p_target_uri_popup.hide()

func _on_JoinButton_pressed():
	_try_connection(p_target_uri.text)

func _on_SettingsButton_pressed():
	get_tree().change_scene("res://scenes/UIscenes/Settings.tscn")

func _on_toggle_fullscreen():
	OS.window_fullscreen = !OS.window_fullscreen

func _update_join_progress(in_progress: bool):
	p_target_uri.editable = !in_progress
	p_target_uri_popup_cancel.disabled = in_progress
	p_target_uri_popup_join.disabled = in_progress

func _try_connection(target_uri):
	_update_join_progress(true)
	var peer = NetworkedMultiplayerENet.new()
	
	if(peer.create_client(target_uri, GameManager.SERVER_PORT) != OK):
		_on_connection_failed()
	else:
		get_tree().network_peer = peer

func _on_connection_successful():
	GameManager.target_uri = p_target_uri.text
	GameManager.peer = get_tree().network_peer

	get_tree().change_scene("res://scenes/MultiClient.tscn")
	
func _on_connection_failed():
	_update_join_progress(false)
