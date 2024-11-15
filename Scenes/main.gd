extends Node2D
@onready var P1Laser=$Player1Pieces/LaserEmitter
@onready var P2Laser=$Player2Pieces/LaserEmitter
@onready var endturn=$UI.end_turn
@onready var endturn_button=$"UI/VBoxContainer/End Turn"
@onready var activeplayerUI=$"UI/VBoxContainer/ActivePlayer"
var move_made=false
var active_player=0#0=player 1, 1=player 2
# Called when the node enters the scene tree for the first time.
func _ready():
	#splash	
	SignalBus.end_condition.connect(_on_end_condition)
	if SignalBus.already_seen_splash==false:
		await get_tree().create_timer(3).timeout
	$Splash/Theme.visible = false
	if SignalBus.already_seen_splash==false:
		await get_tree().create_timer(3).timeout
	$Music.play()
	$Splash/Credits.visible = false
	SignalBus.already_seen_splash=true
	$UI.visible=true#so I can hide it in editor
	endturn.connect(P1Laser.fire_laser)
	P1Laser.laser_fired.connect(post_laser_fired)
	SignalBus.move_made.connect(on_move_made)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func on_move_made(move):
	endturn_button.disabled=!move#disabled if move not yet made
	SignalBus.has_move_been_made=move
	SignalBus.undo_disabled.emit(true)	
	

func post_laser_fired():
	SignalBus.undo_disabled.emit(true)
	if active_player==0:
		endturn.disconnect(P1Laser.fire_laser)
		P1Laser.laser_fired.disconnect(post_laser_fired)
	elif active_player==1:
		endturn.disconnect(P2Laser.fire_laser)
		P2Laser.laser_fired.disconnect(post_laser_fired)
	endturn.connect(switch_turns)
	endturn_button.text="End Turn"
	SignalBus.selection.emit(false)

func switch_turns():
	endturn.disconnect(switch_turns)
	get_tree().call_group("BeamSegments","turnoff")
	endturn_button.text="Fire Laser"
	if active_player==0:
		endturn.connect(P2Laser.fire_laser)
		P2Laser.laser_fired.connect(post_laser_fired)
		active_player=1
		activeplayerUI.text="Player 2"
		SignalBus.is_player1_moving.emit(false)
	elif active_player==1:
		endturn.connect(P1Laser.fire_laser)
		P1Laser.laser_fired.connect(post_laser_fired)
		active_player=0
		activeplayerUI.text="Player 1"
		SignalBus.is_player1_moving.emit(true)
	SignalBus.piece.emit(null)
	SignalBus.move_made.emit(false)
	SignalBus.piece_location=null
	SignalBus.piece_rotation_state=null
		
func _on_end_condition(state):
	if state == true:
		$Splash/RedWins.visible = true
	elif state == false:
		$Splash/BlueWins.visible = true
		
	
func _on_rematch_pressed():
	SignalBus.rematch()
	get_tree().reload_current_scene()
