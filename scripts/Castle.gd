extends Spatial

export var team_id = 0
export var spawn_units = false
export var unit : PackedScene

var type = "castle"
var count = 0

onready var timer = $Timer
onready var enemy_castle = get_node("../EnemyCastle")
onready var spawner = $UnitSpawner

func _ready():
	if spawn_units :
		timer.start()


func hit():
	print("got hit")

func _spawn():
	var spawned = unit.instance() as Spatial
	spawned.transform.origin = spawner.global_transform.origin
	spawned.target = enemy_castle
	$"../".add_child(spawned)
	print("spawned unit")
