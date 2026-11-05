extends Node

@onready var music_player := AudioStreamPlayer.new()

func _ready():
	music_player.bus = "Music"
	add_child(music_player)


func play_sfx(sound: AudioStream, pitch := 1.0):
	var player := AudioStreamPlayer.new()

	player.stream = sound
	player.bus = "SFX"
	player.pitch_scale = pitch

	add_child(player)
	player.play()
	
	player.finished.connect(player.queue_free)


func play_music(music: AudioStream):
	if music_player.stream == music and music_player.playing:
		return

	music_player.stream = music
	
	if not music_player.finished.is_connected(_on_music_finished):
		music_player.finished.connect(_on_music_finished)
	
	music_player.play()

func pause_music():
	music_player.stream_paused = true

func resume_music():
	music_player.stream_paused = false
	
func _on_music_finished():
	music_player.play()
