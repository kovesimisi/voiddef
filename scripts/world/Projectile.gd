extends KinematicBody

var type = "projectile"
var team_id = 0
var atk = 1

var target : Spatial

func _physics_process(delta): 
	if not is_instance_valid(target):
		queue_free()
		return
	
	var target_pos = target.global_transform.origin
	target_pos.y += 1
	var dir = target_pos - global_transform.origin
	dir = dir.normalized() * 50
	
	look_at(target_pos, Vector3.UP)
	var hit = move_and_collide(dir * delta)
	
	if hit and "team_id" in hit.collider and hit.collider.team_id != team_id:
		if hit.collider.has_method("hit"):
			hit.collider.hit(atk)
		queue_free()
