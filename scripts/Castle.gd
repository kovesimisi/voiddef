extends Spatial

var type = "castle"
var hp = 10

export var team_id = 0
export var spawn_units = false
onready var unit = preload("res://objects/Unit.tscn")
onready var tower = preload("res://objects/Tower.tscn")

onready var timer = $Timer
var enemy_castle = null
onready var spawner = $UnitSpawner

func _ready():
	GameManager.castles[team_id] = self
	$Mesh.material = GameManager.tower_materials[team_id]
	if spawn_units:
		timer.start()


func hit(dmg = 1):
	hp -= dmg
	
	if hp <= 0:
		#game over
		get_tree().change_scene("res://scenes/UIscenes/MainMenu.tscn")

func spawn_unit():
	print("spawn unit")
	var spawned = unit.instance() as Spatial
	spawned.transform.origin = spawner.global_transform.origin
	
	if not is_instance_valid(enemy_castle): 
		enemy_castle = GameManager.castles[1 if team_id == 0 else 0]
	
	spawned.target = enemy_castle
	spawned.team_id = team_id
	$"../".add_child(spawned)


func spawn_tower(position):
	var spawned = tower.instance() as Spatial
	spawned.transform.origin = position
	spawned.team_id = team_id
	$"../".add_child(spawned)
