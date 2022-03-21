extends Spatial

var type = "castle"

export var team_id = 0
export var spawn_units = false
export var unit : PackedScene

onready var timer = $Timer
onready var enemy_castle = get_node("../EnemyCastle")
onready var spawner = $UnitSpawner

func _ready():
	if spawn_units :
		timer.start()


func hit():
	pass
	#TODO: hit

func _spawn():
	var spawned = unit.instance() as Spatial
	spawned.transform.origin = spawner.global_transform.origin
	spawned.target = enemy_castle
	$"../".add_child(spawned)
