extends KinematicBody

var target
var team_id = 0
export var hp = 2

func _process(delta):
	var dir = target.global_transform.origin - global_transform.origin
	dir = dir.normalized() * 5
	var hit = move_and_collide(dir * delta)
	if hit:
		if "team_id" in hit.collider and hit.collider.team_id == team_id : 
			return
		if hit.collider.has_method("hit"):
			hit.collider.hit()
		queue_free()
		print("destroyed unit")

func hit():
	hp -= 1
	print("unit hit")
	if hp == 0:
		queue_free()

func imaunit():
	pass
