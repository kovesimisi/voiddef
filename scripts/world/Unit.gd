extends KinematicBody

var type = "unit"

var target : Spatial
var team_id = 0
export var hp = 2
export var spd = 10
export var atk = 1

onready var healthbar = $Healthbar

var max_hp : int

func _ready():
	$Mesh.set_surface_material(0,GameManager.unit_materials[team_id])
	healthbar.value = 1.0
	max_hp = hp

func _process(delta):
	var dir = target.global_transform.origin - global_transform.origin
	dir = dir.normalized() * spd
	var hit = move_and_collide(dir * delta)
	if hit:
		if "type" in hit.collider and hit.collider.type != "tower" and hit.collider.type != "castle":
			return
		if "team_id" in hit.collider and hit.collider.team_id == team_id : 
			return
		if hit.collider.has_method("hit"):
			hit.collider.hit(atk)
		queue_free()

func hit(dmg = 1):
	hp -= dmg
	healthbar.value = float(hp) / max_hp
	
	if hp == 0:
		queue_free()
