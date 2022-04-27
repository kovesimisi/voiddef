extends "res://addons/gut/test.gd"

func before_all():
	GameManager.debug_enabled = true

func test_tower_hit():
	var res = load('res://objects/Tower.tscn')
	var tower = res.instance()
	add_child(tower)
	tower.hp = 2
	assert_eq(2, tower.hp)
	tower.hit()
	assert_eq(1, tower.hp)
	tower.free()

func test_tower_die_on_zero_hp():
	var castleRes = load('res://objects/Castle.tscn')
	var castle = castleRes.instance()
	add_child_autofree(castle)
	yield(get_tree(), "idle_frame")
	var res = load('res://objects/Tower.tscn')
	var tower = res.instance()
	castle.towers.append(tower)
	add_child(tower)
	tower.hp = 1
	yield(get_tree(), "idle_frame")	
	tower.hit()
	yield(get_tree(), "idle_frame")	
	
	assert_freed(tower)
