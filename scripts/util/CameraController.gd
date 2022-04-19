extends Camera

export var team_id = 0

onready var pos_offset = translation

onready var cursor = GameManager.cursors[team_id]

var camera_speed = 100.0

onready var vp = get_viewport()
onready var window_size = OS.window_size

func _ready():
	translation = cursor.translation + pos_offset
	if team_id == 1 : camera_speed *= -1.0
	

func _process(delta):
	# var target_pos = cursor.translation + pos_offset
	# translation =  lerp(translation, target_pos, 0.1)

	var input = Vector2.ZERO

	var mouse = vp.get_mouse_position()

	if mouse.x < 5:
		input.x -= camera_speed

	if mouse.y < 5:
		input.y -= camera_speed

	if mouse.x > window_size.x - 5:
		input.x += camera_speed

	if mouse.y > window_size.y - 5:
		input.y += camera_speed

	translation.x += input.x * delta
	translation.z += input.y * delta
	
	translation.x = clamp(translation.x, -GameManager.world_boundaries.x, GameManager.world_boundaries.x)
	translation.z = clamp(translation.z, -GameManager.world_boundaries.z, GameManager.world_boundaries.z)
	
