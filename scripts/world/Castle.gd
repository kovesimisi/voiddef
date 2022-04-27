extends Spatial

var type = "castle"
var hp = 10
var max_hp = 10
var max_towers = 3
var towers = []
#var unitType = 0
var money=0

export var team_id = 0
#export var spawn_units = false
onready var unit = load("res://objects/Unit.tscn")
onready var unit2 = load("res://objects/Unit2.tscn")
onready var unit3 = load("res://objects/Unit3.tscn")
onready var tower = load("res://objects/Tower.tscn")
onready var tower2 = load("res://objects/Tower2.tscn")

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


	
	
remotesync func spawn_unit(unittype):
	if(GameManager.waiting_for_player()):
		return false
	
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

func _on_Timer_timeout():
	money = money +1

func trytospawnunit(unitType):
	if (money < unitType*5):
		return
	else:
		money = money - unitType*5
	
	
	if(GameManager.is_multiplayer()):
		self.rpc("spawn_unit", unitType) 
	else:
		self.spawn_unit(unitType)

func trytospawntower(place,selected):
	if(money<(selected+1)*2):
		return
	else:
		money = money - (selected+1)*2
	
	if(GameManager.is_multiplayer()):
		self.rpc("spawn_tower", place,selected)
	else:
		self.spawn_tower(place,selected)
