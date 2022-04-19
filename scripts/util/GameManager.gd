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

func _init():
	for c in team_colors:
		var mat = SpatialMaterial.new()
		mat.albedo_color = c
		unit_materials.append(mat)
		
		mat = SpatialMaterial.new()
		mat.albedo_color = c
		tower_materials.append(mat)

func game_start(multiplayer = false):
	if(multiplayer):
		get_tree().change_scene("res://scenes/LocalMulti.tscn")
		
func waiting_for_player():
	return is_multiplayer() && get_tree().is_network_server() && enemy_info == null

func is_multiplayer():
	return peer != null
