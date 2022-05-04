extends KinematicBody

var type = "environment_obj"

var target : Spatial
var team_id = 0
export var hp = 2

onready var healthbar = $Healthbar

var max_hp : int

func _ready():
	$Mesh.set_surface_material(0,GameManager.unit_materials[team_id])
	healthbar.value = 1.0
	max_hp = hp


func hit(dmg = 1):
	hp -= dmg
	healthbar.value = float(hp) / max_hp
	
	if hp == 0:
		queue_free()
