extends Control

onready var msaa_label = $VBoxContainer/MSAAHBox/ValueLabel
onready var msaa_slider = $VBoxContainer/MSAAHBox/ValueSlider
onready var fxaa_toggle = $VBoxContainer/FXAAHBox/ValueToggle
onready var shadow_slider = $VBoxContainer/ShadowsHBox/ValueSlider
onready var shadow_label = $VBoxContainer/ShadowsHBox/ValueLabel
onready var fps_option_btn = $VBoxContainer/FPSHBox/OptionButton
onready var vsync_toggle = $VBoxContainer/VSyncBox/ValueToggle
onready var window_mode_toggle = $VBoxContainer/WindowMode/ValueToggle
onready var volume_slider =$VBoxContainer/VolumeBox/ValueSlider
onready var volume_label =$VBoxContainer/VolumeBox/ValueLabel

const msaa_value_names = ["OFF", "MSAA 2x", "MSAA 4x", "MSAA 8x"]
const shadow_resolution_values = [512, 1024, 2048, 4096]
const shadow_resolution_names = ["Low", "Medium", "High", "Ultra"]
const fps_values = [0, 5, 30, 60, 120, 144]
const volume_values = [0.0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1.0]
const volume_names = ["0", "10", "20", "30", "40", "50", "60", "70", "80", "90", "100"]


func _input(event):
	if event.is_action("ui_cancel"):
		Settings.msaa = msaa_slider.value
		Settings.fxaa = fxaa_toggle.pressed
		Settings.shadow_resolution = shadow_resolution_values[shadow_slider.value]
		Settings.target_fps = fps_values[fps_option_btn.selected]
		Settings.vsync = vsync_toggle.pressed
		Settings.window_fullscreen = window_mode_toggle.pressed
		Settings.volume = float(volume_slider.value / 10)
		Settings.save_config()
		get_tree().change_scene("res://scenes/UIscenes/MainMenu.tscn")


func _ready():
	msaa_slider.value = Settings.msaa
	shadow_slider.value = shadow_resolution_values.find(Settings.shadow_resolution as int)
	fxaa_toggle.pressed = Settings.fxaa
	msaa_slider.grab_focus()
	fps_option_btn.select(fps_values.find(Settings.target_fps))
	vsync_toggle.pressed = Settings.vsync
	window_mode_toggle.pressed = Settings.window_fullscreen
	volume_slider.value = int(Settings.volume * 10)

func _on_MSAASlider_value_changed(value: float):
	msaa_label.text = msaa_value_names[value]


func _on_ShadowSlider_value_changed(value: float):
	shadow_label.text = shadow_resolution_names[value]


func _on_VolumeSlider_value_changed(value: float):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), linear2db(value / 10))
	volume_label.text = volume_names[value]
