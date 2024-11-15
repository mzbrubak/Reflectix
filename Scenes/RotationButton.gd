extends TextureButton
@export var state=Vector3i(0,0,0)#indexes components in xyz, components should be +1,0,or 1
# Called when the node enters the scene tree for the first time.
func _ready():
	pass



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_pressed():
	SignalBus.piece_rotation_state=SignalBus.rotate_piece.state
	SignalBus.set_piece_rotation.emit(state)
	get_tree().call_group("selectors", "queue_free")
	SignalBus.move_made.emit(true)			
	SignalBus.rotation_selection.emit(false)
	SignalBus.undo_disabled.emit(false)
