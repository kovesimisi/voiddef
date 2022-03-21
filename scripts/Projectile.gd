extends KinematicBody

var type = "projectile"

var target : Spatial

func _process(delta): 
	if not is_instance_valid(target):
		queue_free()
		return
		
	var dir = target.global_transform.origin - global_transform.origin
	dir = dir.normalized() * 50
	
	look_at(target.global_transform.origin, Vector3.UP)
	var hit = move_and_collide(dir * delta)
	
	if hit:
		if hit.collider.has_method("hit"):
			hit.collider.hit()
		queue_free()
