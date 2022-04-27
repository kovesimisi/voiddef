extends "res://addons/gut/test.gd"

func before_all():
	pass
	
func test_unit_hp_decrease_on_hit():
	var res = load('res://objects/Unit.tscn')
	var unit = res.instance()
	add_child(unit)
	unit.hp = 2
	assert_eq(2, unit.hp)
	unit.hit()
	assert_eq(1, unit.hp)
	unit.free()
	
func test_unit_die_on_zero_hp():
	var res = load('res://objects/Unit.tscn')
	var unit = res.instance()
	add_child(unit)
	unit.hp = 1
	unit.hit()
	yield(get_tree(), "idle_frame")
	assert_freed(unit, "")
