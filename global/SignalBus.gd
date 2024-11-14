extends Node

signal selection(selected)
signal piece(piece_node)
signal is_player1_moving(player_1_moving)
signal query_piece_rotation(piece_node)#goal: when selecting a piece, get its rotation and z state and send to UI
signal set_piece_rotation(newstate)#goal: when pressing a button in rotation UI, update rotation and z state of piece accordingly
signal move_made(move:bool)
signal undo_disabled(disabled)

var piece_location = null
var has_move_been_made:bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
