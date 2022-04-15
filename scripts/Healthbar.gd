extends CSGMesh

var value : float setget _set_value

func _ready():
	material = material.duplicate()
	
func _set_value(val : float):
	material.set_shader_param("value", val)
