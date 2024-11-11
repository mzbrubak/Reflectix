extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func destroy():
	print("You lose!")
	#put some fun animations here or something, then end-of-game menu
	#could consider moving this code to main and trigger via signal here
