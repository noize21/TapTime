extends TextureButton

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var active =false;

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	#set_normal_texture(mytexture)
	pass
	
func _set_active():
	active=true;
	
	
#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
