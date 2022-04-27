extends 'res://addons/gut/test.gd'

func test_castle_hit():
	var res = load('res://objects/Castle.tscn')
	var castle = res.instance()
	add_child(castle)
	castle.hp = 2
	assert_eq(2, castle.hp)
	castle.hit()
	assert_eq(1, castle.hp)
	castle.free()
	
func test_castle_gameover():
	var res = load('res://objects/Castle.tscn')
	var castle = res.instance()
	add_child(castle)
	castle.hp = 1
	assert_eq(1, castle.hp)
	castle.hit()
	castle.free()
	
func test_castle_spawn_unit():
	var res = load('res://objects/Castle.tscn')
	var castle = res.instance()
	add_child(castle)
	var t = castle.spawn_unit(1, 2)
	assert_eq(t, null)

func test_castle_spawn_tower():
	var res = load('res://objects/Castle.tscn')
	var castle = res.instance()
	add_child(castle)
	var t = castle.spawn_tower(1, 0)
	assert_true(t)
	pass;
	
func test_castle_spawn_tower_overload():
	var res = load('res://objects/Castle.tscn')
	var castle = res.instance()
	add_child(castle)
	castle.max_towers = 1
	var t = castle.spawn_tower(1, 0)
	assert_true(t)
	var t2 = castle.spawn_tower(1, 0)
	assert_true(!t2)
