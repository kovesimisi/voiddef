extends Spatial

export var projectile: PackedScene
onready var timer = $Timer

var ready = false

func _in_range(body):
	if !ready :
		return
		
	print("spawned projectile")
	var spawned = projectile.instance() as Spatial
	spawned.transform.origin = $Area.global_transform.origin
	spawned.target = body
	$"../".add_child(spawned)
	ready = false
	timer.start()


func _cooldown_finished():
	ready = true
