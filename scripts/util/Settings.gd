extends Node

var _config = {
	user_name = "Defender",
	resolution_scale = 1.0,
	fxaa = false,
	msaa = Viewport.MSAA_4X,
	shadow_resolution = 2048,
	target_fps = 60
}

var user_name setget _set_user_name, _get_user_name
var msaa setget _set_msaa, _get_msaa
var fxaa setget _set_fxaa, _get_fxaa
var resolution_scale setget _set_res_scale, _get_res_scale
var shadow_resolution setget _set_shadow_res, _get_shadow_res
var target_fps setget _set_target_fps, _get_target_fps


func _init():
	load_config()


func load_config():
	var config_file = File.new()

	if not config_file.file_exists("user://settings.json"):
		return

		
	config_file.open("user://settings.json", File.READ)

	var loaded = JSON.parse(config_file.get_line()).result
	
	var config_valid : bool = true

	for key in _config:
		if not key in loaded:
			config_valid = false
			break
	
	if config_valid:
		_config = loaded

	_config.target_fps = int(_config.target_fps)

	ProjectSettings.set_setting("directional_shadow/size", _config.shadow_resolution)
	Engine.target_fps = _config.target_fps


func save_config():
	var config_file = File.new()
	config_file.open("user://settings.json", File.WRITE)
	config_file.store_line(JSON.print(_config))


func _set_user_name(name: String):
	_config.user_name = name


func _get_user_name() -> String:
	return _config.user_name


func _set_msaa(level: int):
	_config.msaa = level


func _get_msaa() -> int:
	return _config.msaa


func _set_fxaa(enabled: bool):
	_config.fxaa = enabled


func _get_fxaa() -> bool:
	return _config.fxaa


func _set_res_scale(scale: float):
	_config.resolution_scale = scale


func _get_res_scale() -> float:
	return _config.resolution_scale


func _set_shadow_res(res: int):
	_config.shadow_resolution = res
	ProjectSettings.set_setting("directional_shadow/size", res)


func _get_shadow_res() -> int:
	return _config.shadow_resolution

func _set_target_fps(frames: int):
	_config.target_fps = frames
	Engine.target_fps = frames

func _get_target_fps () -> int:
	return _config.target_fps
