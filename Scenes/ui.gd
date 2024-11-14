extends CanvasLayer
signal undo
signal end_turn

var move_piece;

# Called when the node enters the scene tree for the first time.
func _ready():
	SignalBus.piece.connect(_on_piece)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_undo_pressed():
	if SignalBus.piece_location != null && move_piece != null:
		print("undo")
		move_piece.position = SignalBus.piece_location
		SignalBus.selection.emit(false)
		SignalBus.move_made.emit(false)


func _on_end_turn_pressed():
	end_turn.emit()

func _on_piece(piece_node):
	move_piece = piece_node
