extends Node

var peer

func _ready():
	peer = NetworkedMultiplayerENet.new()
	peer.create_server(GameManager.SERVER_PORT, GameManager.MAX_PLAYERS)
	get_tree().network_peer = peer
	GameManager.peer = peer
	
	get_tree().connect("network_peer_connected", self, "_on_new_connection")
	get_tree().connect("network_peer_disconnected", self, "_on_connection_lost")
	
func _exit_tree():
	print("Tearing down")
	get_tree().network_peer = null
	GameManager.peer = null


func _on_new_connection(id: int):
	GameManager.enemy_info = {}
	print("Connection from %d" % id)

func _on_connection_lost(id: int):
	print("Connection out %d" % id)

