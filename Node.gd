extends Node

# class member variables:

var blacktexture = preload("res://black.png")
var greytexture = preload("res://grey.png")
var whitetexture= preload("res://white.png")

var current_index = 0
var reihe

var time_start
var time_elapsed
var final_time
var highscore = 0

var game_running = false

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	#OS.set_window_size(Vector2(500, 500))
	
	#try to load Highscore from File
	$StoreScore.load_score()
	highscore = $StoreScore.highscore
	get_node("HighscoreLabel").text = "Highscore: " + _formatScore($StoreScore.highscore)
	get_node("HighscoreLabel").set("custom_colors/font_color", Color(1,1,0.5))
	
	get_node("ResetButton").connect("pressed", self, "_reset")
	get_node("TextureButton1").connect("pressed", self, "_block_tapped",[1])
	get_node("TextureButton2").connect("pressed", self, "_block_tapped",[2])
	get_node("TextureButton3").connect("pressed", self, "_block_tapped",[3])
	get_node("TextureButton4").connect("pressed", self, "_block_tapped",[4])
	get_node("TextureButton5").connect("pressed", self, "_block_tapped",[5])
	get_node("TextureButton6").connect("pressed", self, "_block_tapped",[6])
	get_node("TextureButton7").connect("pressed", self, "_block_tapped",[7])
	get_node("TextureButton8").connect("pressed", self, "_block_tapped",[8])
	get_node("TextureButton9").connect("pressed", self, "_block_tapped",[9])
	
	_reset()
	
	pass

func _create_reihe():
	reihe = [5, 6, 1, 2, 3, 8, 9, 4, 7]
	reihe.shuffle()
	print(reihe)

func _block_tapped(id):
	#print("block tapped: " + str(id))
	if(current_index < reihe.size() && id == reihe[current_index]):
		_one_step()

func _first_step():
	for i in range(1,10):
		get_node("TextureButton" + str(i)).set_normal_texture(whitetexture)
	get_node("TextureButton" + str(reihe[0])).set_normal_texture(blacktexture)
	get_node("TextureButton" + str(reihe[1])).set_normal_texture(greytexture)
	

func _one_step():
	#print("current_index: " + str(current_index))
	#print("value at index: " + str(reihe[current_index]))
	#print("next value: " + str(reihe[current_index]+1))
	
	if (current_index == 0):
		time_start = OS.get_ticks_msec()
		game_running = true;
	
	print("pressed: " + str(reihe[current_index]))

	if(current_index+1 < reihe.size()):
		get_node("TextureButton" + str(reihe[current_index+1])).set_normal_texture(blacktexture)
	else:
		print("*** GAME OVER ***")
		final_time = time_elapsed
		if(highscore == 0  ||  final_time < highscore ):
			highscore = final_time
			$StoreScore.save_score(highscore)
			get_node("HighscoreLabel").text = "Highscore: " + _formatScore(final_time)
			get_node("TimeLabel").set("custom_colors/font_color", Color(0,1,0))
		game_running = false;
	
	if(current_index >= 0):
		get_node("TextureButton" + str(reihe[current_index])).set_normal_texture(whitetexture)

	if(current_index+2 < reihe.size()):
		get_node("TextureButton" + str(reihe[current_index+2])).set_normal_texture(greytexture)
	
	current_index +=1

func _reset():
	print("*** RESET ***")
	_create_reihe()
	current_index=0
	_first_step()
	game_running = false
	get_node("TimeLabel").text = "0.00s"
	get_node("TimeLabel").set("custom_colors/font_color", Color(1,1,1))

func _process(delta):
	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
	if(game_running):
		time_elapsed = OS.get_ticks_msec() - time_start
		get_node("TimeLabel").text = _formatScore(time_elapsed)
	pass

	
func _formatScore(var inputscore):
	if (inputscore == 0):
		return "???"
	#expecting at least 1000ms time
	return str(int(inputscore / 1000)) + "," + str((inputscore % 1000)/10) + "s"