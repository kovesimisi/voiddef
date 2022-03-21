extends Spatial

export var projectile: PackedScene
onready var timer = $Timer

var type = "tower"
var targets = []
var ready = false

func _in_range(body):
	#TODO: fix collision layers
	if not "type" in body or body.type!="unit":
		return
	targets.push_back(body)
	shoot()


func _cooldown_finished():
	ready = true
	shoot()

func shoot():
	if !ready :
		return
		
	print("spawned projectile")
	var spawned = projectile.instance() as Spatial
	spawned.transform.origin = $Area.global_transform.origin
	spawned.target = targets.pop_front()
	$"../".add_child(spawned)
	ready = false
	timer.start()


func _out_range(body):
	targets.erase(body)
