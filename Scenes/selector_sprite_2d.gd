extends Sprite2D

var move_piece;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.piece.connect(_on_piece)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		if is_pixel_opaque(get_local_mouse_position()):
			print('test1')
			#move_piece.position += $"..".position
			print('test2')
			
			SignalBus.selection.emit(false)
			queue_free()
			print('test3')

func _on_piece(piece_node):
	move_piece = piece_node
