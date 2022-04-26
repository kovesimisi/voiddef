extends Area

const RAY_LENGTH = 100.0

export var team_id = 0
export var spd = 50
var castle

var selected=0;
var unitType = 0;
var money=0

var input = Vector3.ZERO

const UP = "up"
const DOWN = "down"
const LEFT = "left"
const RIGHT = "right"
const INTERACT = "interact"
const SECONDARY_INTERACT = "secondary_interact"

onready var timer = $Timer
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
	timer.start()

func _input(event):
	if event.is_action_pressed(INTERACT):
		interact()

	if event.is_action_pressed(SECONDARY_INTERACT):
		secondary_interact()
		
	if event.is_action_pressed("next_tower"):
		selected=(selected+1)%2
		
	if event.is_action_pressed("next_unit"):
		unitType = (unitType+1)%3
		castle.unitType = unitType

func interact():
	# selection area empty, place towers
	if get_overlapping_bodies().size() == 0:
		if(GameManager.is_multiplayer()):
			castle.rpc("spawn_tower", global_transform.origin,selected)
		else:
			castle.spawn_tower(global_transform.origin,selected)
	
	#ineract on castle, spawn untis for click
	if get_overlapping_bodies().size() != 0:
		if (unitType==1 and money < 5):
			return
		elif(unitType==1 and money>=5):
			money = money -5
		if (unitType==2 and money < 10):
			return
		elif(unitType==2 and money>=10):
			money = money - 10
		if(GameManager.is_multiplayer()):
			castle.rpc("spawn_unit", get_overlapping_bodies()[0].team_id,unitType)     #.team_id hozzaadva
		else:
			castle.spawn_unit(get_overlapping_bodies()[0].team_id,unitType)
	
func secondary_interact():
	if get_overlapping_bodies().size() != 0:
		if(GameManager.is_multiplayer()):
			castle.rpc("destroy_tower", get_overlapping_bodies()[0])
		else:
			castle.destroy_tower(get_overlapping_bodies()[0])

func _process(_delta):
	# input.z = (Input.get_action_strength(UP % team_id) - Input.get_action_strength(DOWN % team_id)) * (-1)
	# input.x = Input.get_action_strength(RIGHT % team_id) - Input.get_action_strength(LEFT % team_id)
	
	# if team_id == 1: input *= -1
	
	# translation += input * delta * spd

	var mouse = vp.get_mouse_position()

	ray[0] = camera.project_ray_origin(mouse)
	ray[1] = ray[0] + camera.project_ray_normal(mouse) * RAY_LENGTH

func _physics_process(_delta):
	#if 

	var space_state = get_world().direct_space_state
	var result = space_state.intersect_ray(ray[0], ray[1], [], 8)

	if "position" in result:
		translation = result.position

func _on_Timer_timeout():
	money = money +1
	
