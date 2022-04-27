extends "res://addons/gut/test.gd"

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
	var res = load('res://objects/Tower.tscn')
	var tower = res.instance()
	castle.towers.append(tower)
	add_child(tower)
	castle.towers[0].hp = 1
	assert_eq(GameManager.castles[1], castle)
	assert_eq(castle.team_id, 0)
	
	yield(get_tree(), "idle_frame")
	assert_freed(castle.towers[0], "")