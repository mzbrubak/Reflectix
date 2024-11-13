extends Node2D

var is_player1 = true;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func destroy():
	print("You lose! - " + name)
	#put some fun animations here or something, then end-of-game menu
	#could consider moving this code to main and trigger via signal here

func set_player1():
	is_player1 = true
	#$Rotation/Red.visible = true
	#$Rotation/Blue.visible = false

func set_player2():
	is_player1 = false
	#$Rotation/Red.visible = false
	#$Rotation/Blue.visible = true
