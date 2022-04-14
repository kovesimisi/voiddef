extends KinematicBody

var type = "unit"

var target
var team_id = 0
export var hp = 2
export var spd = 10
export var atk = 1

func _ready():
	$Mesh.material = GameManager.unit_materials[team_id]

func _process(delta):
	var dir = target.global_transform.origin - global_transform.origin
	dir = dir.normalized() * spd
	var hit = move_and_collide(dir * delta)
	if hit:
		if "team_id" in hit.collider and hit.collider.team_id == team_id : 
			return
		if hit.collider.has_method("hit"):
			hit.collider.hit(atk)
		queue_free()

func hit(dmg = 1):
	hp -= dmg
	if hp == 0:
		queue_free()
