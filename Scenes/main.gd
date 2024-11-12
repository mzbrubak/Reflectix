extends Node2D
@onready var P1Laser=$Player1Pieces/LaserEmitter
@onready var P2Laser=$Player2Pieces/LaserEmitter
@onready var endturn=$UI.end_turn
@onready var endturn_button=$"UI/VBoxContainer/End Turn"
@onready var activeplayerUI=$"UI/VBoxContainer/ActivePlayer"
var active_player=0#0=player 1, 1=player 2
# Called when the node enters the scene tree for the first time.
func _ready():
	$UI.visible=true#so I can hide it in editor
	endturn.connect(P1Laser.fire_laser)
	P1Laser.laser_fired.connect(post_laser_fired)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func post_laser_fired():
	if active_player==0:
		endturn.disconnect(P1Laser.fire_laser)
		P1Laser.laser_fired.disconnect(post_laser_fired)
	elif active_player==1:
		endturn.disconnect(P2Laser.fire_laser)
		P2Laser.laser_fired.disconnect(post_laser_fired)
	endturn.connect(switch_turns)
	endturn_button.text="End Turn"

func switch_turns():
	endturn.disconnect(switch_turns)
	get_tree().call_group("BeamSegments","turnoff")
	endturn_button.text="Fire Laser"
	if active_player==0:
		endturn.connect(P2Laser.fire_laser)
		P2Laser.laser_fired.connect(post_laser_fired)
		active_player=1
		activeplayerUI.text="Player 2"
	elif active_player==1:
		endturn.connect(P1Laser.fire_laser)
		P1Laser.laser_fired.connect(post_laser_fired)
		active_player=0
		activeplayerUI.text="Player 1"
