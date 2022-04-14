extends Spatial

var type = "tower"
export var team_id = 0
export var hp = 5

var projectile
onready var timer = $Timer
onready var audio_player = $LaserSound

var targets = []
var ready = false

func _ready():
	$Mesh.material = GameManager.tower_materials[team_id]
	projectile = preload("res://objects/Projectile.tscn")

func _in_range(body):
	#TODO: fix collision layers
	if not "type" in body or body.type!="unit" or body.team_id == team_id:
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
	spawned.team_id = team_id
	$"../".add_child(spawned)
	ready = false
	timer.start()
	audio_player.play()


func _out_range(body):
		#TODO: fix collision layers
	if not "type" in body or body.type!="unit" or body.team_id == team_id:
		return
		
	targets.erase(body)

func _process(delta):
	shoot()

func hit(dmg = 1):
	print("tower hit")
	hp -= dmg
	if hp == 0:
		GameManager.castles[team_id].destroy_tower(self)
