extends Node2D
@onready var P1Laser=$Player1Pieces/LaserEmitter
@onready var P2Laser=$Player2Pieces/LaserEmitter
# Called when the node enters the scene tree for the first time.
func _ready():
	$UI.end_turn.connect(P1Laser.fire_laser)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
