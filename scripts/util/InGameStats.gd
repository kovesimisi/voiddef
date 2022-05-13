extends Node


onready var colorrect = $ColorRect
onready var thestats = $Label
onready var cursor = GameManager.cursors[0] if 0 in GameManager.cursors else GameManager.cursors[1]

#get_node("World/PlayerCursor1")
var team_id
var castle
var towerout
var unitout

func _ready():
	colorrect.color = "#24242424"
	
	
	team_id = cursor.team_id
	castle = GameManager.castles[team_id]

func _process(_delta):
	match cursor.unitType:
		0:
			unitout = "Prism"
		1:
			unitout = "Triangle"
		2:
			unitout = "Sphere"
		_:
			unitout = "UnitNotFound"
			
	match cursor.selected:
		0:
			towerout = "Tesla"
		1:
			towerout = "Platter"
		_:
			towerout = "TowerNotFound"
	
	thestats.text = String(castle.money) +"\n"+towerout+"\n"+unitout
	
