extends Area

const RAY_LENGTH = 100.0

export var team_id = 0
export var spd = 50
var castle

var selected=0;
var unitType = 0;


var input = Vector3.ZERO

const UP = "up"
const DOWN = "down"
const LEFT = "left"
const RIGHT = "right"
const INTERACT = "interact"
const SECONDARY_INTERACT = "secondary_interact"


onready var vp = $"/root/Root/ViewportContainer/Viewport"
onready var camera = vp.get_camera()

var ray = [
	Vector3.ZERO,
	Vector3.ZERO
]

func _ready():
	GameManager.cursors[team_id] = self
	$Mesh.material.set_shader_param("albedo_color",  GameManager.team_colors[team_id])
	
	castle = GameManager.castles[team_id]
	

func _input(event):
	if event.is_action_pressed(INTERACT):
		interact()

	if event.is_action_pressed(SECONDARY_INTERACT):
		secondary_interact()
		
	if event.is_action_pressed("next_tower"):
		selected=(selected+1)%2
		
	if event.is_action_pressed("next_unit"):
		unitType = (unitType+1)%3
		#castle.unitType = unitType

func interact():
	var overlapping = get_overlapping_bodies()
	
	# selection area empty, place towers
	if overlapping.size() == 0:
		castle.trytospawntower(global_transform.origin,selected)
		
	
	#something overlaps
	elif("type" in overlapping[0] and overlapping[0].type=="castle" and overlapping[0].team_id == team_id):
		castle.trytospawnunit(unitType)
		
	
func secondary_interact():
	if get_overlapping_bodies().size() != 0:
		if(GameManager.is_multiplayer()):
			castle.rpc("destroy_tower", get_overlapping_bodies()[0])
		else:
			castle.destroy_tower(get_overlapping_bodies()[0])

func _process(_delta):
	var mouse = vp.get_mouse_position()

	ray[0] = camera.project_ray_origin(mouse)
	ray[1] = ray[0] + camera.project_ray_normal(mouse) * RAY_LENGTH

func _physics_process(_delta):
	#if 

	var space_state = get_world().direct_space_state
	var result = space_state.intersect_ray(ray[0], ray[1], [], 8)

	if "position" in result:
		translation = result.position

