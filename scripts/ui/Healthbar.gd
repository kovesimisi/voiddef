extends CSGMesh

var value = 1.0 setget _set_value

func _ready():
	hide()
	
func _set_value(val : float):
	if(val < 1.0):
		material.set_shader_param("value", val)
		show()
