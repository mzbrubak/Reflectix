extends CanvasLayer
signal undo
signal end_turn

@onready var endturn_button=$VBoxContainer/Undo

var move_piece;

# Called when the node enters the scene tree for the first time.
func _ready():
	SignalBus.piece.connect(_on_piece)
	SignalBus.undo_disabled.connect(_on_undo_disabled)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _on_undo_pressed():
	if SignalBus.piece_location != null && move_piece != null:
		move_piece.position = SignalBus.piece_location
		SignalBus.piece_location = null
		SignalBus.undo_disabled.emit(true)
		SignalBus.selection.emit(false)
		SignalBus.move_made.emit(false)
	elif SignalBus.piece_rotation_state!=null&&move_piece!=null:
		move_piece.set_rotation_from_state(SignalBus.piece_rotation_state)
		SignalBus.piece_rotation_state=null
		SignalBus.undo_disabled.emit(true)
		SignalBus.selection.emit(false)
		SignalBus.move_made.emit(false)

func _on_end_turn_pressed():
	end_turn.emit()

func _on_piece(piece_node):
	move_piece = piece_node
	
func _on_undo_disabled(disabled):
	endturn_button.disabled = disabled
