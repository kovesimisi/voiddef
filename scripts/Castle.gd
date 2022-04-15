extends Spatial

var type = "castle"
var hp = 10
var max_hp = 10
var max_towers = 3
var towers = []

export var team_id = 0
export var spawn_units = false
onready var unit = preload("res://objects/Unit.tscn")
onready var tower = preload("res://objects/Tower.tscn")

onready var timer = $Timer
var enemy_castle = null
onready var spawner = $UnitSpawner
onready var healthbar = $Healthbar

func _ready():
	GameManager.castles[team_id] = self
	$Mesh.material = GameManager.tower_materials[team_id]
	if spawn_units:
		timer.start()
	
	healthbar.value = 1.0


func hit(dmg = 1):
	hp -= dmg
	
	healthbar.value = float(hp) / max_hp
	
	if hp <= 0:
		#game over
		get_tree().change_scene("res://scenes/UIscenes/MainMenu.tscn")

func spawn_unit():
	var spawned = unit.instance()
	
	spawned.transform.origin = spawner.global_transform.origin
	
	if not is_instance_valid(enemy_castle): 
		enemy_castle = GameManager.castles[1 if team_id == 0 else 0]
	
	spawned.target = enemy_castle
	spawned.team_id = team_id
	$"../".add_child(spawned)


func spawn_tower(position):
	if towers.size() >= max_towers:
		return false
		
	var spawned = tower.instance() as Spatial
	spawned.transform.origin = position
	spawned.team_id = team_id
	towers.append(spawned)
	$"../".add_child(spawned)
	
	return true

func destroy_tower(tower):
	towers.erase(tower)
	tower.queue_free()
