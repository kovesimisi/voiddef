extends Node

var team_colors = [Color(1,0.1,0.1), Color(0.1,0.1,1)]
var unit_materials = []
var tower_materials = []

var castles = {}
var cursors = {}

var target_uri = null
var peer = null
var enemy_info = null
var world_boundaries = null

const SERVER_PORT = 6000
const MAX_PLAYERS = 2

var debug_enabled = false

func _init():
	for c in team_colors:
		var mat = SpatialMaterial.new()
		mat.albedo_color = c
		unit_materials.append(mat)
		
		mat = SpatialMaterial.new()
		mat.albedo_color = c
		tower_materials.append(mat)
		pause_mode = Node.PAUSE_MODE_PROCESS

func game_start(multiplayer = false):
	if(multiplayer):
		get_tree().change_scene("res://scenes/LocalMulti.tscn")
		
func waiting_for_player():
	return is_multiplayer() && get_tree().is_network_server() && enemy_info == null

func is_multiplayer():
	return peer != null

func show_dialog(title, text):
	var dialog = AcceptDialog.new()
	get_tree().root.add_child(dialog)
	dialog.pause_mode = Node.PAUSE_MODE_PROCESS
	dialog.window_title = title
	dialog.dialog_text = text
	dialog.popup_centered_minsize(Vector2(150,50))
	return dialog

func load_menu():
	get_tree().paused = false
	get_tree().change_scene("res://scenes/UIscenes/MainMenu.tscn")
	

remotesync func game_over(team_id):
	if debug_enabled: return
	get_tree().paused = true
	var dialog = show_dialog("Game over","Player %d has won" % (team_id + 1))
	dialog.connect("confirmed", self, "load_menu")
