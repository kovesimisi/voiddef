extends Spatial

var type = "castle"
var hp = 10

export var team_id = 0
export var spawn_units = false
export var unit : PackedScene

onready var timer = $Timer
var enemy_castle = null
onready var spawner = $UnitSpawner

func _init():
	GameManager.castles.insert(team_id, self)

func _ready():
	$Mesh.material = GameManager.tower_materials[team_id]
	enemy_castle = GameManager.castles[1 if team_id == 0 else 0]
	if spawn_units:
		timer.start()


func hit():
	hp -= 1
	
	if hp <= 0:
		#game over
		get_tree().change_scene("res://scenes/UIscenes/MainMenu.tscn")

func _spawn():
	var spawned = unit.instance() as Spatial
	spawned.transform.origin = spawner.global_transform.origin
	spawned.target = enemy_castle
	spawned.team_id = team_id
	$"../".add_child(spawned)
