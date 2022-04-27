extends 'res://addons/gut/test.gd'

func before_all():
	GameManager.debug_enabled = true

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
	var enemy_castle = res.instance()
	enemy_castle.team_id = 1
	add_child(castle)
	add_child(enemy_castle)
	var t = castle.spawn_unit(2)
	assert_true(is_instance_valid(t))

func test_castle_spawn_tower():
	var res = load('res://objects/Castle.tscn')
	var castle = res.instance()
	add_child(castle)
	var t = castle.spawn_tower(Vector3.ZERO, 0)
	assert_true(t)
	pass;
	
func test_castle_spawn_tower_overload():
	var res = load('res://objects/Castle.tscn')
	var castle = res.instance()
	add_child(castle)
	castle.max_towers = 1
	var t = castle.spawn_tower(Vector3.ZERO, 0)
	assert_true(t)
	var t2 = castle.spawn_tower(Vector3.ZERO, 0)
	assert_true(!t2)
