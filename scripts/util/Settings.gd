extends Node

var _config = {
	user_name = "Defender",
	resolution_scale = 1.0,
	fxaa = false,
	msaa = Viewport.MSAA_4X,
	shadow_resolution = 2048,
	fps = 60
}

var user_name setget _set_user_name, _get_user_name
var msaa setget _set_msaa, _get_msaa
var fxaa setget _set_fxaa, _get_fxaa
var resolution_scale setget _set_res_scale, _get_res_scale
var shadow_resolution setget _set_shadow_res, _get_shadow_res
var fps setget _set_fps, _get_fps


func _init():
	load_config()


func load_config():
	var config_file = File.new()

	if not config_file.file_exists("user://settings.json"):
		return

	config_file.open("user://settings.json", File.READ)

	_config = JSON.parse(config_file.get_line()).result
	ProjectSettings.set_setting("directional_shadow/size", _config.shadow_resolution)
	Engine.target_fps = _config.fps


func save_config():
	var config_file = File.new()
	config_file.open("user://settings.json", File.WRITE)
	config_file.store_line(JSON.print(_config))


func _set_user_name(name: String):
	_config.user_name = name


func _get_user_name():
	return _config.user_name


func _set_msaa(level: int):
	_config.msaa = level


func _get_msaa():
	return _config.msaa


func _set_fxaa(enabled: bool):
	_config.fxaa = enabled


func _get_fxaa():
	return _config.fxaa


func _set_res_scale(scale: float):
	_config.resolution_scale = scale


func _get_res_scale():
	return _config.resolution_scale


func _set_shadow_res(res: int):
	_config.shadow_resolution = res
	ProjectSettings.set_setting("directional_shadow/size", res)


func _get_shadow_res():
	return _config.shadow_resolution

func _set_fps(frames: int):
	_config.fps = frames
	Engine.target_fps = frames

func _get_fps():
	return _config.fps
