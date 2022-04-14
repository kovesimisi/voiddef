extends Area

export var team_id = 0
export var spd = 50
var castle

var input = Vector3.ZERO

const UP = "up_%d"
const DOWN = "down_%d"
const LEFT = "left_%d"
const RIGHT = "right_%d"
const INTERACT = "interact_%d"

func _ready():
	GameManager.cursors[team_id] = self
	var mat = SpatialMaterial.new()
	mat.albedo_color = GameManager.team_colors[team_id]
	$Mesh.material = mat
	
	castle = GameManager.castles[team_id]

func _input(event):
	if event.is_action_pressed(INTERACT % team_id):
		interact()

func interact():
	castle.spawn_tower(global_transform.origin)
	

func _process(delta):
	input.z = (Input.get_action_strength(UP % team_id) - Input.get_action_strength(DOWN % team_id)) * (-1)
	input.x = Input.get_action_strength(RIGHT % team_id) - Input.get_action_strength(LEFT % team_id)
	
	if team_id == 1: input *= -1
	
	translation += input * delta * spd
