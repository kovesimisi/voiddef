extends Camera

export var team_id = 0

onready var pos_offset = translation

onready var cursor = GameManager.cursors[team_id]

func _process(delta):
	var target_pos = cursor.translation + pos_offset
	translation =  lerp(translation, target_pos, 0.1)
