extends CanvasLayer
signal undo
signal end_turn


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_undo_pressed():
	pass # will implement later


func _on_end_turn_pressed():
	end_turn.emit()
	SignalBus.selection.emit(false)
