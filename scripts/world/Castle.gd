extends Spatial

var type = "castle"
var hp = 10
var max_hp = 10
var max_towers = 3
var towers = []
var unitType = 0

export var team_id = 0
#export var spawn_units = false
onready var unit = preload("res://objects/Unit.tscn")
onready var unit2 = preload("res://objects/Unit2.tscn")
onready var unit3 = preload("res://objects/Unit3.tscn")
onready var tower = preload("res://objects/Tower.tscn")
onready var tower2 = preload("res://objects/Tower2.tscn")

onready var timer = $Timer
var enemy_castle = null
onready var spawner = $UnitSpawner
onready var healthbar = $Healthbar

func _ready():
	GameManager.castles[team_id] = self
	$Visual/Mesh.material = GameManager.tower_materials[team_id]
	#$Visual/Mesh.material = GameManager.unit_materials[team_id]
	#if spawn_units:
		#timer.start()
	timer.start()
	healthbar.value = 1.0


func hit(dmg = 1):
	hp -= dmg
	
	healthbar.value = float(hp) / max_hp
	
	if hp <= 0:
		if GameManager.is_multiplayer() :
			GameManager.rpc("game_over", team_id)
		else:
			GameManager.game_over(team_id)
		#game over
#		get_tree().change_scene("res://scenes/UIscenes/MainMenu.tscn")


	
	
remotesync func spawn_unit(_onCastle,unittype):
	if(GameManager.waiting_for_player()):
		return
	
	#"type" in _onCastle and _onCastle.type == "castle"   kiszedve a feltételből
	if _onCastle == team_id:
		var spawned;
		if (unittype == 0):
			spawned = unit.instance() as Spatial
		elif(unittype == 1):
			spawned = unit2.instance() as Spatial
		elif(unittype == 2):
			spawned = unit3.instance() as Spatial
		spawned.transform.origin = spawner.global_transform.origin
	
		if not is_instance_valid(enemy_castle): 
			enemy_castle = GameManager.castles[1 if team_id == 0 else 0]
	
		spawned.target = enemy_castle
		spawned.team_id = team_id
		$"../".add_child(spawned)
		
		return true


remotesync func spawn_tower(position,selected):
	if(GameManager.waiting_for_player()):
		return
		
	if towers.size() >= max_towers:
		return false
		
	var spawned;
	if (selected==0):
		spawned = tower.instance() as Spatial
	else:
		spawned = tower2.instance() as Spatial
	spawned.transform.origin = position
	spawned.team_id = team_id
	towers.append(spawned)
	$"../".add_child(spawned)
	
	return true

remotesync func destroy_tower(_tower):
	if "type" in _tower and _tower.type == "tower" and _tower.team_id == team_id:
		towers.erase(_tower)
		_tower.queue_free()
