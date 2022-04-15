extends Node

func _ready():
	var peer = GameManager.peer
	get_tree().network_peer = peer
	
	peer.connect("server_disconnected", self, "_on_server_disconnected")

func _exit_tree():
	get_tree().network_peer = null

func _on_server_disconnected():
	get_tree().change_scene("res://scenes/UIscenes/MainMenu.tscn")
	print("Server is gone")
