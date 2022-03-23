extends Spatial

var type = "tower"

export var projectile: PackedScene
onready var timer = $Timer
onready var audio_player = $LaserSound

var targets = []
var ready = false

func _in_range(body):
	#TODO: fix collision layers
	if not "type" in body or body.type!="unit":
		return
	
	targets.push_back(body)


func _cooldown_finished():
	ready = true

func shoot():
	if !ready or targets.empty() :
		return
		
	var spawned = projectile.instance() as Spatial
	spawned.transform.origin = $Area.global_transform.origin
	spawned.target = targets.pop_front()
	$"../".add_child(spawned)
	ready = false
	timer.start()
	audio_player.play()


func _out_range(body):
	targets.erase(body)

func _process(delta):
	shoot()
