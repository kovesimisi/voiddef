extends Label

var acc = 0.0
var c = 0

func _process(delta):
	acc += delta
	c += 1
	if acc > 0.2 :
		text = String(round(1/(delta/c)))
		delta = 0.0
		c = 0
