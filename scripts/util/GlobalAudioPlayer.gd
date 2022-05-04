extends AudioStreamPlayer

var music_lib : Dictionary
var _currently_playing = ""

func _init():
	volume_db = 2
	music_lib["menu"] = load("res://assets/audio/menumusic.wav")
	music_lib["game"] = load("res://assets/audio/gamemusic.wav")
	

func play_music(music : String):
	if _currently_playing == music:
		return true
		
	if not music in music_lib:
		return false
	
	_currently_playing = music
	stream = music_lib[music]
	play()
	return true
