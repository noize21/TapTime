extends Node

# filename to store the data - note the path
var score_file = "user://highscore"
var highscore = 0

# call this at the beginning of your game.
# Tests to see if the file exists and loads the contents if it does
func load_score():
	var f = File.new()
	if f.file_exists(score_file):
		print("exists")
		var err = f.open_encrypted_with_pass("user://highscore", File.READ, "dfgdbisuarodsugkad")
		var content = f.get_as_text()
		highscore = int(content)
		f.close()
	print("exists not")

# call this at game end to store a new highscore
func save_score(var highscore):
	var f = File.new()
	var err = f.open_encrypted_with_pass("user://highscore", File.WRITE, "dfgdbisuarodsugkad")	
	f.store_string(str(highscore))
	f.close()