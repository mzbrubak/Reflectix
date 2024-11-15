extends Sprite2D

var move_piece;


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.piece.connect(_on_piece)
	SignalBus.selector_derender.connect(_on_derender)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		if is_pixel_opaque(get_local_mouse_position()):			
			SignalBus.selector_derender.emit()
			print("pre-timer:"+name)
			$"../MoveTimer".start()

func _on_piece(piece_node):
	move_piece = piece_node

func _on_derender():
	$"..".visible = false

func _on_move_timer_timeout() -> void:	
	print("timer:"+name)
	var pos = $"..".position
	SignalBus.piece_location = $"../..".position
	move_piece.position += pos
	await get_tree().create_timer(0.01).timeout
	
	SignalBus.move_made.emit(true)			
	SignalBus.rotation_selection.emit(false)
	SignalBus.undo_disabled.emit(false)
	get_tree().call_group("selectors", "queue_free")
